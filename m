Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1AB1EA0AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgFAJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:14:45 -0400
Received: from foss.arm.com ([217.140.110.172]:35244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFAJOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:14:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE0E21FB;
        Mon,  1 Jun 2020 02:14:44 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B12293F305;
        Mon,  1 Jun 2020 02:14:43 -0700 (PDT)
Date:   Mon, 1 Jun 2020 10:14:41 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Will Deacon <will@kernel.org>, Kyle Huey <khuey@pernos.co>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: arm64: Register modification during syscall entry/exit stop
Message-ID: <20200601091441.GW5031@arm.com>
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck>
 <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck>
 <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck>
 <20200527101929.GT5031@arm.com>
 <20200531093320.GA30204@willie-the-truck>
 <CABV8kRyHo+EAWaMUzGA220z=HJRBCpH6UWiYGb84uSL3h8HQHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRyHo+EAWaMUzGA220z=HJRBCpH6UWiYGb84uSL3h8HQHw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 12:13:18PM -0400, Keno Fischer wrote:
> > Keno -- are you planning to send out a patch? You previously spoke about
> > implementing this using PTRACE_SETOPTIONS.
> 
> Yes, I'll have a patch for you. Though I've come to the conclusion
> that introducing a new regset is probably a better way to solve it.
> We can then also expose orig_x0 at the same time and give it sane semantics
> (there's some problems with the way it works currently - I'll write it up
> together with the patch).

I'd worry that having a new ptrace option would be useless bug-
compatibility that is just going to bitrot.

Can you explain why userspace would write a changed value for x7
but at the same time need that new to be thrown away?

That sounds like a nonsensical thing for userspace to be doing.

Cheers
---Dave
