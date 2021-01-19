Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01BC2FB753
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390854AbhASKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:42:00 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:61942 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbhASK0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:26:51 -0500
Date:   Tue, 19 Jan 2021 10:25:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1611051928;
        bh=dGTiJERg2zrXOU4dpZd3X9IAeQN+fZzG/gcS0Jtabiw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=dcx3TG5KQ33Iaqa7uRJ8WYc+NlJKsFibIrf4N5/TzMEYbwwoegvrJzh8SKu5iCy45
         KDRtMbu8qQaMN5fzUy37zMEmRCMUowm+SiaIRvtGZSnf4XB24CAh+nek0CjTMZf2Rw
         a+HPgKoPKZVZNSs03KKb/QGPfeKTQ5pnb4Pssiu60piRu5GUjy+VDH2AeuboX7atG1
         3L48bCon/WSj70Uq5mE0xC52elPkhYLs6oXim0d3IxU7qACf+82DdpTN+Fpk/3asc3
         Nqzs1DP/OxVJUdgU9QiBA+9QuAPp1qGXnpQxFM+ZxF5UZTfzkt8Jidwt3UPWuDIioK
         v2Q2oAtoT7C2A==
To:     Lyude Paul <lyude@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     nouveau@lists.freedesktop.org, Martin Peres <martin.peres@free.fr>,
        Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 1/5] drm/nouveau/kms/nv50-: Use drm_dbg_kms() in crc.c
Message-ID: <2QHYyJzLbrCUmrL_JECoVAa2stPs0keGJC0bBudh70My2JI9zjZFlh_aL-uRe5cGDZv4Pt8sI3mEoPG1Nw8liNzYPuMm4yLbRQqmg5SL5MI=@emersion.fr>
In-Reply-To: <20210119014849.2509965-2-lyude@redhat.com>
References: <20210119014849.2509965-1-lyude@redhat.com> <20210119014849.2509965-2-lyude@redhat.com>
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

> Cc: Martin Peres <martin.peres@free.fr>
> Cc: Jeremy Cline <jcline@redhat.com>
> Cc: Simon Ser <contact@emersion.fr>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Code LGTM:

Reviewed-by: Simon Ser <contact@emersion.fr>

