Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5390624D7A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgHUOrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 10:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgHUOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:46:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB591C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:46:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so2166889wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZFr4XoJFpaIz23d6NSRjCG2LiEByEgRMPwwSPTPGfHU=;
        b=LV3BKd+w1Kq9Koipbm2pKTwtvtWC1kcGm1ZsOijs0kINQEoxmcMNwMcVkGQrq5dvDh
         JBQW2QXDMFClTwCgfwcIuNLJBrk1m93bBSzxbtarWHdw6uOf6u5JjeduyvnuXjjXX1Rm
         2VSp8onGrF/hdxc7FQKL2D3CI5LAJV+n7RZSTx+9cqLg6J2Ts9iL/+KcUnlLIl9Nbup0
         Fve45+kL82CIuDlC+PX2cP3TPAkYMkLFONLn01dCvnR+0g4O8Z+N2EdM2q4CLiTepybo
         irkLsVuR/5D1vmqtfCSIikmEcvd7rABYAkAmcy1V8Elgn7DCVXR+7G4JFv1uRPXBsRvr
         GQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZFr4XoJFpaIz23d6NSRjCG2LiEByEgRMPwwSPTPGfHU=;
        b=VUPmWWSaq2nLu27LVDTMGLhEOl4YMfl+/ZZ+4GKPb3U/Qroo3ki7p5z2B5CX1FhmJm
         8iGHmySTSRbmhv74m5gQp9CwBF+c/2qIw0v9v+L9t6r0nBoHImimDE2GwAvv1Ba4q17e
         b4wBHKi8IvBKlNUxepMwHXt1/A5u4yXBManOrSCH8IfWRuTjzb380vF7p0tv+yvl8ak2
         t7I5sXdFQdX+mOK8MDnqK6a7PvwI9cdJtMO5DlZnqgE63yK/ydiR7zmV+qK9x6jDnUwT
         6dnDZD6RVFGYIx/CE0OGu8zdh4cIGNVVtICjRFcrK8r96woI1oKVH/lOtYsIsZoxCpcJ
         9XPQ==
X-Gm-Message-State: AOAM53304vxs5Km7ma3xDJgk3uWovhWsOljK2xq1H7SXzrBpjddbKopd
        mZPoATn32qWhCFKowEdYsXqMG/bXmnkNsA==
X-Google-Smtp-Source: ABdhPJy0R1Rx7xG/6tsk88fFuqZOVlDcYsn6MZfi3M5FqkmxTvi8qrtNL/6hVcOdEhBhzYS5Fzp/7Q==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr3235534wrv.217.1598021216351;
        Fri, 21 Aug 2020 07:46:56 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id r21sm4940384wrc.2.2020.08.21.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:46:55 -0700 (PDT)
Date:   Fri, 21 Aug 2020 15:46:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: core: Fix double-free in mfd_remove_devices_fn()
Message-ID: <20200821144653.GF3248864@dell>
References: <20200817235048.24577-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200817235048.24577-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020, Dmitry Osipenko wrote:

> The pdev.mfd_cell is released by platform_device_release(), which is
> invoked by platform_device_unregister(). Hence mfd_remove_devices_fn()
> shouldn't release the cell variable. The double-free bug is reported KASAN
> during of MFD driver module removal.
> 
> Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/mfd-core.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
