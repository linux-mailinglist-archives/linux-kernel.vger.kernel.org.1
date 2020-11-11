Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985AD2AE830
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgKKFhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:37:23 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:35610 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKFhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:37:23 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2020 00:37:21 EST
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 11 Nov 2020 14:07:19 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 11 Nov 2020 14:07:19 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 11 Nov 2020 14:05:59 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: [RFC] Are you good with Lockdep?
Message-ID: <20201111050559.GA24438@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

We have no choise but to use Lockdep to track dependencies for deadlock
detection with the current kernel. I'm wondering if they are satifsied
in that tool. Lockdep has too big problems to continue to use.

---

PROBLEM 1) First of all, Lockdep gets disabled on the first detection.

   What if there are more than two problems? We cannot get reported
   other than the first one. So the one who has introduced the first one
   should fix it as soon as possible so that the other problems can be
   reported and fixed. It will get even worse if it's a false positive
   because it's worth nothing but only preventing reporting real ones.

   That's why kernel developers are so sensitive to Lockdep's false
   positive reporting - I would, too. But precisely speaking, it's a
   problem of how Lockdep was designed and implemented, not false
   positive itself. Annoying false positives - as WARN()'s messages are
   annoying - should be fixed but we don't have to be as sensitive as we
   are now if the tool keeps normally working even after reporting.

   But it's very hard to achieve it with Lockdep because of the complex
   design. Maybe re-designing and re-implementing almost whole code
   would be required.

PROBLEM 2) Lockdep forces us to emulate lock acquisition for non-lock.

   We add manual annotations for non-lock code in the following way:

   At the interest wait,

      ...
      lockdep_acquire(X);
      lockdep_release(X);
      wait_for_something(X);
      ...

   At begin and end of the region where we expect there's the something,

      ...
      lockdep_acquire(X);
      (or lockdep_acquire_read(); to allow recursive annotations.)
      function_doing_the_something(X);
      lockdep_release(X);
      ...

   This way we try to detect deadlocks by waits for now. But don't you
   think it looks ugly? Are you good if it manages to work by some
   means? That even doesn't work correctly. Instead it should look like:

   At the interest wait,

      ...
      xxx_wait(X);
      wait_for_something(X);
      ...

   At the something,

      ...
      xxx_event(X);
      do_the_something(X);
      ...

   Or at begin and end of the region for hint,

      ...
      xxx_event_context_enter(X);
      function_doing_the_something(X);
      xxx_event_context_exit(X);
      ...

   Lockdep had been a not bad tool for detecting deadlock by problematic
   acquisition order. But it's worth noting that deadlock is caused by
   *waits* and their *events* that never reach. Deadlock detection tool
   should focus on waits and events instead of lock acquisition order.

   Just FYI, it should look like for locks:

   At the interest lock acquisition,

      ...
      xxx_wait(X);
      xxx_event_context_enter(X);
      lock(X);
      ...

   At the lock acquisition using trylock type,

      ...
      xxx_event_context_enter(X);
      lock(X);
      ...

   At the lock release,

      ...
      xxx_event(X);
      xxx_event_context_exit(X);
      unlock(X);
      ...

---

These two are big-why we should not keep using Lockdep as a deadlock
detection tool. Other small things can be fixed by modifying Lockdep but
these two are not.

Fine. What could we do for it? Options that I've considered are:

---

OPTION 1) Revert reverting cross-release locking checks (e966eaeeb62
locking/lockdep: Remove the cross-release locking checks) or implement
another Lockdep extention like cross-release.

   The reason cross-release was reverted was a few false positives -
   someone was lying like there were too many false positives though -
   leading people to disable Lockdep. I admit it had to be done that way.
   Folks still don't like Lockdep's false positive that stops the tool.

OPTION 2) Newally design and implement another tool for deadlock
detection based on wait-event model. And replace Lockdep right away.

   Lockdep definitely includes all the efforts great developers have
   made for a long time as as to be quite stable enough. But the new one
   is not. It's not good idea to replace Lockdep right away.

OPTION 3) Newally design and implement another tool for deadlock
detection based on wait-event model. And keep both Lockdep and the new
tool until the new one gets considered stable.

   For people who need stronger capacity for deadlock detection, the new
   tool needs to be introduced but de-coupled with Lockdep so as to be
   getting matured independently. I think this option is the best.

   I have the patch set. Let me share it with you in a few days.

---

Thanks,
Byungchul
