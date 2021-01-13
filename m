Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B42F4AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhAMLtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbhAMLtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:49:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F825233F7;
        Wed, 13 Jan 2021 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610538534;
        bh=6MPSPxQzlSexDkpYDQlKOtZACSnb7I9vUTzl6vaEO+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zur2ysx04C8Px6/Z0EKnbIUp7FO3lGsxQ0mvIkIHL9Y3HymUKlEe7V1Sj1BQi8YNY
         zJA3GqhseIydq7e90ODEQr9Ia7SR/Ctc5e+MYl+dJOAuC0hDIiMNbODpQozsGJIvbg
         zok/ZmdKANuAdTiza6C2fh1eqmk2mdBPiZLQmS1/sxxztotWnWsjLAsM9pHn34beV4
         9MqAiOEflgle6dfxAVdtr8Fw1yqWa1f6fWWiZrheWKbrkyS4qtwwIcawhhjHQCIpu4
         8/gNvhnw3p6pdDyhCjTaGQnlMUshnV13x8VBR0gZf0MolIo1ypzVAps7F4+RvHm5jv
         xii5obJVil5MA==
Date:   Wed, 13 Jan 2021 17:18:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     kishon@ti.com, tony@atomide.com, pavel@ucw.cz,
        christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: cpcap-usb: remove unneeded conversion to bool
Message-ID: <20210113114849.GC2771@vkoul-mobl>
References: <1607598716-16108-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607598716-16108-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-20, 19:11, Tian Tao wrote:
> Fix the following warning:
> drivers/phy/motorola/phy-cpcap-usb.c:146:31-36: WARNING: conversion to
> bool not needed here.

Applied, thanks

-- 
~Vinod
