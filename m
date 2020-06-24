Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A292072F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbgFXMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 08:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389662AbgFXMLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:11:55 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE552088E;
        Wed, 24 Jun 2020 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593000714;
        bh=CQ/YeKAURQSn20ZnWuAL465EuGhpy6ENS1WftOqmBRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFhhECB2bBcWWbaA/blSHYyHT2xWdn6egPYPPzlls+ZvlC+cVid/Xz/rwhvxwe0vH
         /fajBgaTX2hyBmLTS83OZexUHKF9QAi+Mw6/QKn+N2nbZoRBZNcS3ymxHG8HVxr2Kj
         +6cSNpa7EI23afwb/hfV9/qis8RB9nRo8PHnMm0A=
Date:   Wed, 24 Jun 2020 17:41:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] phy: intel: fix enum type mismatch warning
Message-ID: <20200624121150.GA2324254@vkoul-mobl>
References: <20200527134518.908624-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527134518.908624-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-05-20, 15:45, Arnd Bergmann wrote:
> clang points out that a local variable is initialized with
> an enum value of the wrong type:
> 
> drivers/phy/intel/phy-intel-combo.c:202:34: error: implicit conversion from enumeration type 'enum intel_phy_mode' to different enumeration type 'enum intel_combo_mode' [-Werror,-Wenum-conversion]
>         enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
>                               ~~~~~~~   ^~~~~~~~~~~~~
> 
> >From reading the code, it seems that this was not only the
> wrong type, but not even supposed to be a code path that can
> happen in practice.
> 
> Change the code to have no default phy mode but instead return an
> error for invalid input.

Applied, thanks

-- 
~Vinod
