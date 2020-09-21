Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0342730A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgIURG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgIURGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:06:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F86C061755;
        Mon, 21 Sep 2020 10:06:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y17so14859848lfa.8;
        Mon, 21 Sep 2020 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8wJgx44R5NKEt8ZxeLzaDEWfeS0v7G2Y9ErgN5IEyXg=;
        b=mNzQWgo+B1fYnaeTLARkCvewjZg9HcnUglJrVlEkdaZTsCBIwUdVhKu5NsKRipjeQl
         +1Wb3BXlWXspQ2UTLhPpdoU9WPdPtcVRDOjY1+OHzOIPtdUKC3zdTjFu8H9kkPgrxw7z
         2EcpQhxo/HWFLZuFnAdTDEcWg9CAwLZU8KXlDofQqam3nJYziheaG1pj/UunWc8rNMio
         abvFCVFfgLLT6dMxNQacRIhRtFiYHhHIcjWuS6yhs3ZjH87yQMtBVelNSq13ro/Zai38
         0fqd0ADEiyc4SFMVvin6lcxWOWmCnUl5oWu34M0fJozt9u0cvg2ZG8TIraFXcnL3jIhu
         UqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8wJgx44R5NKEt8ZxeLzaDEWfeS0v7G2Y9ErgN5IEyXg=;
        b=ImdNeu/+gTIFGFIWnvlWdT900xsOdn5gtRcK6U6KkjL2KU42O+fOS5XRPWbTmHfaqM
         SDJ9ontHUJW9yIoa3CaQMPtGE0mocQPSIx/YxKWgFEf9p9eNArt5cKmju+DIcT9lU+4R
         WoiNDkmq8/FC4R/I+lGboQupSPKusd0PRur2hVhlwaCD3+BQcapubwXlT5H0hXH1KZQF
         nMmysmQ0rKnFElre5FYsKx3osaX/5w+JMTkLD6WrCNqvDC19gGFeup2+FH60q8iKeFj5
         6KQf7PsNQkxU8C4K3greU7G1WwfZnEEpjX3AZjFDGf664I07W6HVZosDu28oJ+8azLyr
         UTbg==
X-Gm-Message-State: AOAM5315uD3b/Ha97QF8AJR8BbrWLunnCXmX/G0fzqhm3Y9k9XUqrpW6
        HOma+hBQhcwSqeaHNKp+pjpz1m6J/wDnqp7EtaE=
X-Google-Smtp-Source: ABdhPJy8Jx5FwPowb4x2/95hAu/YP49gaxE6kf58oAxWBlMcnqfEtK51ywXCEko0zW0B8PeMXMJkQu5o+HuhTqI2OmY=
X-Received: by 2002:a19:820c:: with SMTP id e12mr262729lfd.215.1600707966915;
 Mon, 21 Sep 2020 10:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600707235.git.agx@sigxcpu.org> <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
In-Reply-To: <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Sep 2020 14:05:55 -0300
Message-ID: <CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] dt-binding: display: Require two rests on
 mantix panel
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Mon, Sep 21, 2020 at 1:56 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> We need to reset both for the panel to show an image.

There is a typo in "resets" in the Subject line.
