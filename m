Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CBE2A4A88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgKCQAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:00:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33210 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgKCQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:00:11 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7BB5720B4905;
        Tue,  3 Nov 2020 08:00:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BB5720B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604419210;
        bh=J8OE5ZE7jXON1484ORv8lZUJPUcUXaUAPElDol454sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHY1HLID8EYf4MCBxuPPFXO4ao4hhVlm+HdRYUmHw9suUnj+vjfJ2XH+LHtJpMD/U
         caIs8H5q2nKxEtWZwQh/Yh42pwB5nf0NrC75Q/MkPtXo2bTGcSqkMyHY95AeRDsvv9
         P+ZFbGY7JNm0okNTvEUzmJ6/vYN5QsCv8LVQyG5I=
Date:   Tue, 3 Nov 2020 09:59:52 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: Implement CONFIG_CMDLINE_EXTEND
Message-ID: <20201103155952.GA4335@sequoia>
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-21 14:15:55, Tyler Hicks wrote:
> Provide the CONFIG_CMDLINE_EXTEND config option for arm64 kernels. This
> config option can be used to extend the kernel command line parameters,
> specified by the bootloader, with additional command line parameters
> specified in the kernel configuration.

Hi Catalin and Will - Friendly ping on this series now that we're
on the other side of the 5.10 merge window. I hope it can be considered
for 5.10+1. Let me know if I need to rebase/resubmit. Thanks!

Tyler
