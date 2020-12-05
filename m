Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC732CFA9D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgLEI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728798AbgLEIL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:11:28 -0500
Date:   Sat, 5 Dec 2020 13:40:58 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607155863;
        bh=mGO4D/CrxcgVNF2XS6aa7J5jfeliiJlvfRPD2/JDX2Q=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=FytETiNBT8lwOtSUknHqUWOsZvEFo0GDLHUrl2+V7imaRlt/mcRQV+R2x0oEfM5V5
         nPM8x6j3kzVAA+s9tjj0x7tpq6kQ7nK0nV2TLccNC+oan2fVm8kHHyzkrC5QNui3sn
         PcPYCdHKpSoo/4aGHAIagjSxfCZ0iFMnLs5i4f/iacOaCywbSNgnuZQSEJN/i0RSyp
         GQCdtM/MlhZrqkX1keBBVqJIEvd5gv3C/vN++Jg/VNL15pgFvYTK/QujunF5NKLiEh
         pRh0luQlWvKQVqA9Ig/l2IbCljiCsJiy7OqO1A2gfhylNihh527fq2YPIo6Vg8rGNp
         zE6CauPE5OgSQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/2] phy: rockchip: set otapdlysec for in dts
Message-ID: <20201205081058.GY8403@vkoul-mobl>
References: <20201202082507.3536-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202082507.3536-1-chris.ruehl@gtsys.com.hk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-20, 16:25, Chris Ruehl wrote:
> This patchset add support to set output-tapdelay-selec via dt property

Applied, thanks

-- 
~Vinod
