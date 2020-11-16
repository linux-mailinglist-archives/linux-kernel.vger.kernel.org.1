Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561392B4240
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgKPLI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:08:27 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:50306 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgKPLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:08:26 -0500
Date:   Mon, 16 Nov 2020 11:08:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1605524903;
        bh=QGhi54MdNuZPb1+rrhFwdkR6s6Cgk8mVP/zIusN9TRs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DwTv/PZdOIVkD5yYisQNusXYtUo94jyX5zKb8OaM6tAx7mXnwpAxxCfaib5crVwUv
         EmmzLowY+OJhzYpeOZK1D1heZ+G1IGOGdrnb9zHYoO/Fmbf+dJdzL5uftmTokmgB+x
         wqVQbhNKCm1kRh/rPvb+j22cLVkfSbTefDNfZ75BAR3TpU9R8hx97PRnS3OnA9fHpp
         c6AFhKUpQ7OlBEUOFxUAGtJ/WqsZmy/4NMSeoIFThoaJ3jLf73VqJZrS7tr7PoGSru
         MY+5U1lOfqNr5ZwwYgYBdf/sQM+ol3jkmc5E148KcCr9rGlNQ/AHwOnlPy6UWB9/R9
         lqP7YsC3iCuMg==
To:     Colin King <colin.king@canonical.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH][next] drm/atomic: avoid null pointer dereference on pointer crtc
Message-ID: <Gsgkd1PRlRQd3tlZ0nZROZwVfLvE7QmJdeOA8wkeVyE9ewGIj89RZAixoLltsvvgqB-Ica_sfpcNbwdtRCjDx16tYykgs61QOJRYm9Eumys=@emersion.fr>
In-Reply-To: <20201116110316.269934-1-colin.king@canonical.com>
References: <20201116110316.269934-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 16, 2020 12:03 PM, Colin King <colin.king@canonical.com=
> wrote:

> From: Colin Ian King colin.king@canonical.com
>
> Since moving to the new debug helper functions we now have a debug messag=
e
> that dereferences crtc to print a kernel debug message when crtc is null
> and so this debug message will now cause a null pointer dereference. Sinc=
e
> this is a debug message it probably is just simplest to fix this by just
> removing the debug message altogether.

NACK. This removes the log altogether instead of fixing it.

A fix has already been pushed to drm-misc-next: 0003b687ee6d ("drm: fix
oops in drm_atomic_set_crtc_for_connector").
