Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1910A1C64F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgEFATD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 20:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgEFATD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:19:03 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 17:19:03 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id g2so11444vsb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxf7PIfuQA1AmzwbgiAc6qi52bK5LTEy5mM67o299pg=;
        b=YP9DojNnvL0GKT59bxFJk7GMLrsEk2LCd5aowl6qLFcQdpPAxIs6zTVGg2i6fYhDJz
         dyvRxqWVH9vP7aAeBY2R+7ovwrMKFqgr+zf5hfdg2ome+cQL9T+tX2oEiMp15mZ3FxB7
         qL0Sg3ZHqsoiZp8InrBjMlJzG2kBeeYmEkBsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxf7PIfuQA1AmzwbgiAc6qi52bK5LTEy5mM67o299pg=;
        b=e1emW5Z4YJELKh4Ap5aXGYNXKJZLPekNEvdMOKAEnRoZi5zuDwWvhmj+il8oVhH2hD
         VlgNO7xUJig731xffSV31i4SmCAFikBgikTeE+zuQBFI2xCYLf2HYsh+FS0Woe8k7zPz
         /g1/+EEQ9jpb7Y8Qg8nNuH2ilefvErGOuqTP+GYAQCJ8Wzn9uhWOXjKtdmOgMN5yo4/3
         4MSoXIRdsthqzQwwt1UBZE6Gi0Y1c8OTHf33AeaEaH2Grr9BaHE6mh7j0i6VlFxJZpOm
         ZGzkL8TtyXIDjB3B6aOU5a4v7lkiOI5GWB07UUjVEIS/4WgMmGZTLaeu+mnkJHU4xZtc
         Ysng==
X-Gm-Message-State: AGi0PubZgKtj48Erp4w3U2Tw3iIZ9pjDEsUVbXJM3f8HewxlP61RFAL4
        aC4TPZr4BGD4ypX0iOwDjn9TdrMnbxU=
X-Google-Smtp-Source: APiQypKPMioIXPbmV+hY0AZtVeD4NXoa+IxIbXUqZYZGeKjYB7rip1TsSdogKQcRJaZhIpc1fwrIzA==
X-Received: by 2002:a67:f957:: with SMTP id u23mr5877488vsq.146.1588724341905;
        Tue, 05 May 2020 17:19:01 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id q25sm84107uap.1.2020.05.05.17.19.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 17:19:00 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id g2so11397vsb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:19:00 -0700 (PDT)
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr5406597vsp.198.1588724340078;
 Tue, 05 May 2020 17:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200504213624.1.Ibc8eeddcee94984a608d6900b46f9ffde4045da4@changeid>
 <20200505082436.GD9658@pendragon.ideasonboard.com> <CAD=FV=WjUpwu5204K8yHzqsJv4vQX5S5CArH1Kj_kqjhZzTc9A@mail.gmail.com>
 <20200505210609.GA6094@pendragon.ideasonboard.com> <CAD=FV=UnGOYh8JX2=fEAqPN7wqANc0QevTirNO-WUDYMPqXcrg@mail.gmail.com>
 <20200505211401.GC6094@pendragon.ideasonboard.com> <CAD=FV=WgRC-HViMxttF4VK+n48HNRuqAau8S7mgx6oSWsbZcgA@mail.gmail.com>
In-Reply-To: <CAD=FV=WgRC-HViMxttF4VK+n48HNRuqAau8S7mgx6oSWsbZcgA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 May 2020 17:18:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8_Krob9oftJjzrYs1zrbLr9WZ-HSStv5_rbq9MpTChw@mail.gmail.com>
Message-ID: <CAD=FV=U8_Krob9oftJjzrYs1zrbLr9WZ-HSStv5_rbq9MpTChw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Implement lane reordering + polarity
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 5, 2020 at 2:24 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, May 5, 2020 at 2:14 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > > I'll add this documentation into the comments of the yaml, but I'm not
> > > going to try to implement enforcement at the yaml level.
> >
> > Why not ? :-)
>
> Because trying to describe anything in the yaml bindings that doesn't
> fit in the exact pattern of things that the yaml bindings are designed
> to check is like constructing the empire state building with only
> toothpicks.
>
> If you want to suggest some syntax that would actually make this
> doable without blowing out the yaml bindings then I'm happy to add it.
> Me being naive would assume that we'd need to do an exhaustive list of
> the OK combinations.  That would be fine for the 1-land and 2-lane
> cases, but for 4 lanes that means adding 256 entries to the bindings.
>
> I think the correct way to do this would require adding code in the
> <https://github.com/devicetree-org/dt-schema> project but that's
> really only done for generic subsystem-level concepts and not for a
> single driver.

OK.  Looked at your review of the .yaml and the "uniqueItems" is
probably the bit I didn't think of.  With that I can limit this but
it's still a little awkward.  I still haven't figured out how to force
data-lanes and lane-polarities to have the same number of items, too.
I'll add this as an add-on patch to my v2 and folks can decide if they
like it or hate it.

# See ../../media/video-interface.txt for details.
data-lanes:
  oneOf:
    - minItems: 1
      maxItems: 1
      uniqueItems: true
      items:
        enum:
          - 0
          - 1
      description:
        If you have 1 logical lane it can go to either physical
        port 0 or port 1.  Port 0 is suggested.

    - minItems: 2
      maxItems: 2
      uniqueItems: true
      items:
        enum:
          - 0
          - 1
      description:
        If you have 2 logical lanes they can be reordered on
        physical ports 0 and 1.

    - minItems: 4
      maxItems: 4
      uniqueItems: true
      items:
        enum:
          - 0
          - 1
          - 2
          - 3
      description:
        If you have 4 logical lanes they can be reordered on
        in any way.

-Doug
