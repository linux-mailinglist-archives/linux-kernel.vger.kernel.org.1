Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C8619C4DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbgDBOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:53:08 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:10129 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388855AbgDBOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:53:07 -0400
Received: from xps-7390 (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48tQzP4d8fzHyQ;
        Thu,  2 Apr 2020 10:53:05 -0400 (EDT)
Date:   Thu, 2 Apr 2020 07:53:04 -0700 (PDT)
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
In-Reply-To: <20200402144618.GC20730@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.2004020747010.10453@xps-7390>
References: <20200402123258.895628824@linutronix.de> <alpine.DEB.2.21.2004020641470.7052@xps-7390> <20200402143203.GJ20713@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.2004020735210.10453@xps-7390>
 <20200402144618.GC20730@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > (Also, what "thing" exactly did you want?)

On Thu, 2 Apr 2020, Peter Zijlstra wrote:

> All the .ko files that come with vmware.

Ah, gotcha. One thing you/VMWare may want to look at is it turns out that
"vmw_vmci", part of the kernel tree (CONFIG_VMWARE_VMCI) has to be compiled
into the kernel as a module so udev can properly create the Misc device node
(I'd tried making it a built-in and messing with udev rules and the other,
compiled-in-later VMWare module loading system didn't seem to like that).

Maybe some sort of mitigation for this can be done there, putting it back in-tree?

But anyway, I'll send you a .tar.bz2 in a little bit.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
