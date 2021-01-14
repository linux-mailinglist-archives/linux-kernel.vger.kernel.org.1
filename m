Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C202F5C28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbhANIHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:07:50 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:43596 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbhANIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:07:45 -0500
Date:   Thu, 14 Jan 2021 08:06:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1610611621;
        bh=oZoLOvB8GFNjTNukq9k4F1x8Zrh7VuJWPVVKWBKbx6E=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=QntvKbV1vbBi+N/094QDG70LEkXfRBGSma8e3IoD4jHW+TxXVRJbXS9E1IGSKVB4d
         r1x0dNCfc3xC0p7aPRVYcrCXoU/zHBPHs6VcIudLRyY/D8YlQtBOAIlUwlLWFsLTy6
         mmrHtEA0JagQIO6GtkHlDdNY/uA5IsOJr5urCGRkg+G8K4w/hmRuPgq8lufieWChJD
         5TcCRFeHcuvG+KLwDvBouFhhnl7ADS8pN4F/SPg4uoyG/3rE7WKxn3YWUzTM7WuiUy
         5RjlIBQoAGXy+1qVUL3Mhm74oiIaUtj7oCiQnrh+BFVUKoZzfMmZCwRP8ixSh6c4yY
         2Kh9d84w2LHiw==
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v6 15/16] drm: drm_crc: fix a kernel-doc markup
Message-ID: <qe1toq6DLvoVNP7AaQXNqpa3qtfzGwKWuVz-uYiDIUcI0u0-xaQstZKPNqEbg9-lfHA0wN2yI_i-vQvoYJmoOS_v-XLO1pUfFE-9srEsxNY=@emersion.fr>
In-Reply-To: <2439fb6713e9b2aa27a81f3269a4b0e8e7dfcd36.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org> <2439fb6713e9b2aa27a81f3269a4b0e8e7dfcd36.1610610937.git.mchehab+huawei@kernel.org>
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

On Thursday, January 14th, 2021 at 9:04 AM, Mauro Carvalho Chehab <mchehab+=
huawei@kernel.org> wrote:

> A function has a different name between their prototype
> and its kernel-doc markup:
>
> =09../include/drm/drm_crtc.h:1257: warning: expecting prototype for drm_c=
rtc_alloc_with_planes(). Prototype was for drmm_crtc_alloc_with_planes() in=
stead
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Simon Ser <contact@emersion.fr>
