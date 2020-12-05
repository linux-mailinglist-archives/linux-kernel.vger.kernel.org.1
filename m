Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8462CFA56
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 08:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgLEHrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 02:47:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgLEHrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 02:47:15 -0500
Date:   Sat, 5 Dec 2020 13:16:30 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607154394;
        bh=3ovR2MSyO+5/qt/IdHjAeJTXVn/uSem0OvtClb/IKYY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mR64EfcjossT4dvgyqNo2s0QxeHD4B4OnnuBSTJ97ChyfEhqsayWgvB9oPJkJpmnO
         MijbMcIsSSZFXB+WeWoNAVRYB6I6geCI6/5+u1klCUKvfrmHHuKGK6l1/+9obtkHxf
         Mm+S25PIuoAx5/eSylCbvA58Gt98U9YLxRcaKAEzsqdmbypFY64OYJ/PezSDwHLikj
         YtX7rtGVlECjQ7TyYrP440oUZhCSnq0KLQ5uzET2y2d+2f9HynodMKj6zNTYBP+85+
         49PHFLOKzuBBdNIE/AC19dkWhZaXY8UDP01OeAAXmo9ittIXuT/LQrNCM62VYEvdKQ
         l0V+hlcGy5u7Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 5/7] regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
Message-ID: <20201205074630.GS8403@vkoul-mobl>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-6-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202204645.23891-6-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-20, 04:46, Bard Liao wrote:

>  MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");

Why do you want to change this ?

> -- 
> 2.17.1

-- 
~Vinod
