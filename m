Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B161619C480
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbgDBOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:41:45 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:62096 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbgDBOlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:41:44 -0400
Received: from xps-7390 (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48tQkG1s0qzGZC;
        Thu,  2 Apr 2020 10:41:42 -0400 (EDT)
Date:   Thu, 2 Apr 2020 07:41:41 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 0/2] x86: Prevent Split-Lock-Detection wreckage on VMX
 hypervisors
In-Reply-To: <20200402143203.GJ20713@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.2004020735210.10453@xps-7390>
References: <20200402123258.895628824@linutronix.de> <alpine.DEB.2.21.2004020641470.7052@xps-7390> <20200402143203.GJ20713@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Apr 2020, Peter Zijlstra wrote:

> Hmm, you're not seeing this:
>   +       pr_warn("disabled due to VMLAUNCH in module: %s\n", me->name);
> fire when you load the vmware kernel module?

I just looked back at the syslog's copy of the kernel messages at the time
I'd tried it, and no, I don't see that message.

> Could you slip me a copy of that thing by private mail?

OK, gimme a couple of days though, I've gotta get a little work done.
(Also, what "thing" exactly did you want?)

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
