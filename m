Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DAF2F9F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391407AbhARMWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:22:55 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47186 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391393AbhARMUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:20:37 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1TVb-0003kl-8b; Mon, 18 Jan 2021 13:19:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     sam@ravnborg.org, Heiko Stuebner <heiko@sntech.de>,
        thierry.reding@gmail.com
Cc:     airlied@linux.ie, dianders@chromium.org,
        dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: panel-simple: add bus-format and connector-type to Innolux n116bge
Date:   Mon, 18 Jan 2021 13:19:45 +0100
Message-Id: <161097237013.280087.214437214113895613.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109130951.3448435-1-heiko@sntech.de>
References: <20210109130951.3448435-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jan 2021 14:09:51 +0100, Heiko Stuebner wrote:
> The Innolux n116bge panel has an eDP connector and 3*6 bits bus format.

Applied, thanks!

[1/1] drm/panel: panel-simple: add bus-format and connector-type to Innolux n116bge
      commit: 87969bcd49480508568070fd93d7367f03316aa9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
