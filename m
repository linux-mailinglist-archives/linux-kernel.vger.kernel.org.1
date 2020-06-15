Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705C01F9F92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbgFOSkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 14:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731396AbgFOSkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:40:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E512720756;
        Mon, 15 Jun 2020 18:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592246445;
        bh=wYKSzzrOtt+X56zSeQ03eBE8TXYYdvcqWroESoJynwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlbC55WjaV4nWjXst3bO4kQANNHVW3FGiuCtr8vFlGcnmBmTIfSmQIdfqtWf9eBUK
         cIN+7izIRzNmFLxWid1bL5vtlZHL+Rmo5IF+CB3GwKRQEXag5ljpRfAwfyXz5DKRDn
         DLrujyfyBpBB29ranjrdCSpWM2Susi+UFnuTceTc=
Date:   Mon, 15 Jun 2020 20:40:41 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Park, Kyung Min" <kyung.min.park@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] Documentation/x86: Add documentation for
 /proc/cpuinfo feature flags
Message-ID: <20200615184041.GA177504@kroah.com>
References: <20200610200701.16757-1-kyung.min.park@intel.com>
 <20200610200701.16757-2-kyung.min.park@intel.com>
 <20200615181527.GM14668@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F66C552@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F66C552@ORSMSX115.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:31:50PM +0000, Luck, Tony wrote:
> > In general, this should say something along the lines that /proc/cpuinfo
> > shows features which the kernel supports.
> >
> > "For a full list of CPUID flags which the CPU supports, use
> > tools/arch/x86/tools/cpuid/cpuid"
> >
> > :-)
> 
> Dave Hansen had suggested (offline) that we add a cpuid tool to the kernel sources.
> 
> I think that's a lot of (duplicated) work for someone to maintain.  The version of this
> tool at http://www.etallen.com/cpuid.html is close to 10K lines of code.

10k is nothing, have you looked at tools/perf/ ?  :)

greg k-h
