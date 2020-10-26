Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80897298DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421188AbgJZNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:22:49 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:42442 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1776988AbgJZNUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:20:00 -0400
Received: by mail-oo1-f66.google.com with SMTP id l26so1175521oop.9;
        Mon, 26 Oct 2020 06:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5V74H5JuHP7LZrTQlerYiUXU3pYxv+LpdxUgjv8arc=;
        b=TAjUvkj/jfVlgzAD1GtsaQ2NkbLttDx+Seb1ccrvMKjXrT1sHhsoWPGBjgX9hqnHlp
         aMCxU4L2rn/mWZqI86KYEaByJ0bsKf90L0Ezu7fnV635yj2dma6gSWfqLKsnoAI7zy4m
         8MB00qeur2FffwjKyGueO8nuY6fR8zRAwmqra4pFFxrin6ebQne91c7TjvOua9bPs+HX
         PAeyBGaAkdVBtRdE7S3XIvaiofjJpL7b4Ty7kOl9oouxlSFkUvSr0+dvEOckcj/NVozb
         GP8trpfi6phAnzjCsfYc1srxBqcuscFipUkkmx7uwAKRu4vh0oAyG9HNO3VAOXeD64p/
         3uZQ==
X-Gm-Message-State: AOAM530svh2my2ii11OVzKH/6inxrk/sYB4r6JR60Ek6VIuwFSDajNrs
        DEj0YyvQXYBcqAm8KojuuA==
X-Google-Smtp-Source: ABdhPJxlxZGzNp5Qy7jehOdA9r8xkKsLvjdTXkUpwwVK9y+I569/IzmokE39lu12/73EPOV+AphQQQ==
X-Received: by 2002:a4a:d083:: with SMTP id i3mr13483342oor.74.1603718399379;
        Mon, 26 Oct 2020 06:19:59 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f18sm3514302otp.10.2020.10.26.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:19:58 -0700 (PDT)
Received: (nullmailer pid 19048 invoked by uid 1000);
        Mon, 26 Oct 2020 13:19:57 -0000
Date:   Mon, 26 Oct 2020 08:19:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        nsaenzjulienne@suse.de, alsa-devel@alsa-project.org,
        broonie@kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/7] of: base: Add of_count_phandle_with_fixed_args()
Message-ID: <20201026131957.GA19011@bogus>
References: <20201016173541.21180-1-rf@opensource.cirrus.com>
 <20201016173541.21180-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016173541.21180-2-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 18:35:35 +0100, Richard Fitzgerald wrote:
> Add an equivalent of of_count_phandle_with_args() for fixed argument
> sets, to pair with of_parse_phandle_with_fixed_args().
> 
> The existing of_count_phandle_with_args() is modified to be a
> private function that handles both cases and the public functions
> are trivial wrappers round that.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/of/base.c  | 73 +++++++++++++++++++++++++++++++---------------
>  include/linux/of.h |  9 ++++++
>  2 files changed, 59 insertions(+), 23 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
