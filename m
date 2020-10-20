Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4346B293A11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393136AbgJTLcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392173AbgJTLcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:32:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6009122242;
        Tue, 20 Oct 2020 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603193533;
        bh=Nsrn+3HPUDvw02TPj/mLosWUjt3K/Jrh2U/x9bCQraQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPrxMgUAzQnNL7HJGe1PE/pgpcd9UyL/SGsDQUclJ5BYNk5bO9zVOq7/4n1Ti6gzm
         9fl/nmSPDKjeUW5vdGV4zLCpMaQ7UsSNDjeXpc9yxAkY8L7TEMqL75lcAske9rnM47
         TWOCD7FB/5KAupmBSZsYB8EiCRLY99z00IjKrbN4=
Date:   Tue, 20 Oct 2020 12:32:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Will Deacon <willdeacon@google.com>, catalin.marinas@arm.com,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] arm64: Fix a broken copyright header in
 gen_vdso_offsets.sh
Message-ID: <20201020113207.GB16084@willie-the-truck>
References: <20201017002637.503579-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017002637.503579-1-palmer@dabbelt.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 05:26:37PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> I was going to copy this but I didn't want to chase around the build
> system stuff so I did it a different way.

How did you end up doing it? I remember trying to parse the ELF object at
one time of day and not getting very far.

Will
