Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11EC619C383
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbgDBOBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:01:48 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:64870 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgDBOBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:01:47 -0400
X-Greylist: delayed 1105 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 10:01:47 EDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 48tPQz2JSzzDS3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 09:43:23 -0400 (EDT)
Received: from xps-7390 (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48tPQw5R8rz1P23;
        Thu,  2 Apr 2020 09:43:20 -0400 (EDT)
Date:   Thu, 2 Apr 2020 06:43:19 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
In-Reply-To: <20200402123258.895628824@linutronix.de>
Message-ID: <alpine.DEB.2.21.2004020641470.7052@xps-7390>
References: <20200402123258.895628824@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Apr 2020, Thomas Gleixner wrote:

> As Peter and myself don't have access to a SLD enabled machine, the
> KVM/VMX part is untested. The module scan part works.

I just applied both of these patches to my (Linus' tip) tree, and unfortunately
VMWare still hangs if split_lock_detect= is set to anything but "off".

Was there anything else I'd needed to do?

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
