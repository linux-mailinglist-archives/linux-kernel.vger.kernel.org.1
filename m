Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B041B0152
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 08:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDTGHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 02:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgDTGHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:07:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24EA2206F6;
        Mon, 20 Apr 2020 06:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587362868;
        bh=vRlhz0sSThzWyJx9IOhI/eegJBUk6Cj/zG1nKsnkmaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7vHSaBwJ8N37qDzSwQ1YcjnLP2iNKH4h1S9VkIFdToeSZoXNNpDlBuwhnz9Y5L+p
         ZeHad1mH2Fpvg8gPLjN4OCeUSSn7JUXoIhjbVAmt2frMpX9mtqgvX2i40BOqbbLFQV
         PoAP3bLc06hr9aDE5Ronyxg2Yuu47rQPthhckobA=
Date:   Mon, 20 Apr 2020 08:07:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fixed broken microcode early loading on 32 bit
 platforms because it always jumps past cpuid in sync_core() as data
 structure boot_cpu_data are not populated so early in boot. This is for 4.4.
 Should be done for 4.9 too
Message-ID: <20200420060746.GB3704191@kroah.com>
References: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
 <20200419162943.3704-2-evalds.iodzevics@gmail.com>
 <20200419165453.GB3697654@kroah.com>
 <CADqhmmc4S=BPTGuK2iCxD0ZwHf8cobyFq4f+jsBtHZZJtJD+5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqhmmc4S=BPTGuK2iCxD0ZwHf8cobyFq4f+jsBtHZZJtJD+5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:52:07AM +0300, Evalds Iodzevics wrote:
> Yeah, basically its a fix for early microcode load on x86 for 4.4 longterm
> Just tried to say same problem exists on 4.9 too

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
