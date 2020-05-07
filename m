Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A055D1C9AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgEGTPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728328AbgEGTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:15:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81663C05BD43;
        Thu,  7 May 2020 12:15:06 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CFFE6453;
        Thu,  7 May 2020 19:15:04 +0000 (UTC)
Date:   Thu, 7 May 2020 13:15:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Xu <peterx@redhat.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200507131503.02aba5a6@lwn.net>
In-Reply-To: <20200506193816.GB228260@xz-x1>
References: <20200423002632.224776-1-dancol@google.com>
        <20200423002632.224776-3-dancol@google.com>
        <20200506193816.GB228260@xz-x1>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 15:38:16 -0400
Peter Xu <peterx@redhat.com> wrote:

> If this is going to be added... I am thinking whether it should be easier to
> add another value for unprivileged_userfaultfd, rather than a new sysctl. E.g.:
> 
>   "0": unprivileged userfaultfd forbidden
>   "1": unprivileged userfaultfd allowed (both user/kernel faults)
>   "2": unprivileged userfaultfd allowed (only user faults)
> 
> Because after all unprivileged_userfaultfd_user_mode_only will be meaningless
> (iiuc) if unprivileged_userfaultfd=0.  The default value will also be the same
> as before ("1") then.

It occurs to me to wonder whether this interface should also let an admin
block *privileged* user from handling kernel-space faults?  In a
secure-boot/lockdown setting, this could be a hardening measure that keeps
a (somewhat) restricted root user from expanding their privilege...?

jon
