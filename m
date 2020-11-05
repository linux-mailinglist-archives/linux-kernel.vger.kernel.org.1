Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD32A7AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgKEJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgKEJd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:33:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0E72080D;
        Thu,  5 Nov 2020 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604568837;
        bh=iWSRERkC/LfV2CVxk1yU2P6qcmSeHGDgDs/NaKLTet0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEaD68BnGh3Zwcv0U3b5cKS7Mi5m/d5QnC3E8AVdik0bOeKQlnZcLdT/kPArORZ0J
         9H5Bu2roGr4h+ZC6TQQVasX7hgfaQpnGtbMJ78+n7FPC+zRb3XN71oypHOPzwWby2Q
         DSq2UVehupaPumkcUExNDWEi9e3E9N8CuhW6w0Os=
Date:   Thu, 5 Nov 2020 09:33:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add KRYO2XX Errata / mitigations data
Message-ID: <20201105093349.GA7902@willie-the-truck>
References: <20201104232218.198800-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104232218.198800-1-konrad.dybcio@somainline.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

[+Jeffrey]

On Thu, Nov 05, 2020 at 12:22:09AM +0100, Konrad Dybcio wrote:
> This series adds Spectre mitigations and errata data for
> Qualcomm KRYO2XX Gold (big) and Silver (LITTLE) series of
> CPU cores, used for example in MSM8998 and SDM660-series SoCs.
> 
> Konrad Dybcio (4):
>   arm64: Add MIDR value for KRYO2XX gold/silver CPU cores
>   arm64: kpti: Add KRYO2XX gold/silver CPU cores to kpti safelist
>   arm64: proton-pack: Add KRYO2XX silver CPUs to spectre-v2 safe-list
>   arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX Silver

This mostly looks fine to me, but I've added Jeffrey to check the MIDRs
because he's my go-to person for the Qualcomm numbering scheme.

Jeffrey -- please can you check these patches [1], especially the last patch
which has some cryptic revision number in there too?

Cheers,

Will

[1] http://lkml.kernel.org/r/20201104232218.198800-1-konrad.dybcio@somainline.org
