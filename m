Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42C22FDA12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392808AbhATTuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392616AbhATTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:49:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3719C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:48:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 15so15916607pgx.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lRzUAv3or2r1BbPajS2z+ykRpWXBnGJf5rpZ5p6tBU=;
        b=b7XgurA3tAmpc0/KrE+SrYu+wzF575qE3w5hAl0FoEebHa52Yts9CiUoEPqUD2CUGj
         g1CDS83gzRO7wECoszUiNN+l4Vc5iFcQkeDVsKYtjaKtZ2T6gj8wH6WUmRt9KZwBktxu
         TVKv1RG3ibphKebujjufhqlgq1MB1yGeH9PJH6DnI56Rs9F+sm5+9biMMlCWIJT932L7
         aQU5EV+XYmM4Yt2GNgxKT7wzrh7p+dw/PciwyebeJNLqC+BEUY4JCMCwpnhKLgSiCOHS
         E2y2l0U50Ex4hQxkwIXReKocVQ8L7dMObdTPeVcmBnhvTrrXpmMreQA9gxjqkrK3tFkd
         NZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lRzUAv3or2r1BbPajS2z+ykRpWXBnGJf5rpZ5p6tBU=;
        b=lSyLr+b8CmrKzpKgNSLGcuFDSQXcs6wfg7GzPOcDgDCSKQeoBMC4/ns7+jLzgKF2QS
         eTScAvnhrJHYbWTsR7ti/4RW+MBYAIMv3G/YkumuJHUmnCWA3z+kvk4/TbOedgfS1XE6
         8LEX18RmibcxNDkQv2oItYtTYUMldjW/kDVWyLNj+igAYCQv7YGVREpTo/uQwApDt8Vi
         f+d6Q18x5ultyo7qCZYqPDJDX4Nws2StPhmgZVXCK8degR+M7Riu+lMvr+dj8Nlq325Y
         l9XNg6AHg30S1jfkMqIewUwpfppjRoTK0sz7UQPAS7grvivYpJfAAF5fHH8+LoeRXmUu
         kjZw==
X-Gm-Message-State: AOAM531RuHFvqpjxsAwXuIbrnqClfCqOTb1gW+nGCQrHROZUDYZ++NLp
        JQlKgTBlQP1/DYKe1L9hr3Q=
X-Google-Smtp-Source: ABdhPJyUu2UkRkMJ+bnE1P2Fk1vfzHOfdMVVbLOxf9bjZ06450ndMipRmjBzuMQwNzha3T3HBEln0A==
X-Received: by 2002:a63:6f0d:: with SMTP id k13mr10948851pgc.256.1611172133494;
        Wed, 20 Jan 2021 11:48:53 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z6sm3183298pfj.22.2021.01.20.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 11:48:52 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH Broadcom/stblinux] soc: brcmstb: add stubs for getting platform IDs
Date:   Wed, 20 Jan 2021 11:48:51 -0800
Message-Id: <20210120194851.2775816-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114105318.14970-1-zajec5@gmail.com>
References: <20210114105318.14970-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 11:53:18 +0100, Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Some brcmstb drivers may be shared with other SoC families. E.g. the
> same USB PHY block is shared by brcmstb and BCM4908.
> 
> To avoid building brcmstb common code on non-brcmstb platforms we need
> stubs for:
> 1. brcmstb_get_family_id()
> 2. brcmstb_get_product_id()
> (to avoid "undefined reference to" errors).
> 
> With this change PHY_BRCM_USB will not have to unconditionally select
> SOC_BRCMSTB anymore.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied to drivers/next, thanks!
--
Florian
