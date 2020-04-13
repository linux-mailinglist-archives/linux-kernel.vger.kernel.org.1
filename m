Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294181A650C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgDMKLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 06:11:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42047 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgDMKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:11:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id s10so3166248edy.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+7Q/wT0Mnct4ipSNlbYLt8kOVOarKScVBUfZKd/RJw=;
        b=hcLAK4qPC/NwZZe5uW4u78OKlDzVTHprBL56p/KDCHqq2Q80vxbJl2c7IZJT3Y9cvh
         hkgYmEELSIpftD990b83jf4D/Y/9pHxkXT4CdK649+rJQ061gcnu0fWL1l8uC5fwTvZR
         u6+9bKEeZa7+GBlpuBTooI5SDckxUAIbHJ/gBIGnwb4JdQOfZNdLlz9M60JQnRwHVxxs
         v7p37vJbkYIDDCQ+aqV5/PnTjiII+2R1VrJNTJ5H8u2B4gFOLNYZZwvC01sx+JpUWvXN
         2wC79bAZTCmtqGI8bbCNhnbE+elH4Iko1MyaQ1lVIRhvVvll2WHE1qd5m13+MlulDmgx
         DVKQ==
X-Gm-Message-State: AGi0PuYcp2dQ8vdxady+6EAXQimjEgT6r7ZCYdedi6D5R1gDi41asYVn
        6vHVIxThdanKKlLsPQPsfJhlLiwm87g=
X-Google-Smtp-Source: APiQypINQQfZFUm0sliciBKV4Sgha823b1py9AtmzTSI10elg8f1Ifj/eSXRHswcFBlx6vWGtyCYLA==
X-Received: by 2002:a17:906:4351:: with SMTP id z17mr15327855ejm.346.1586772692730;
        Mon, 13 Apr 2020 03:11:32 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id p23sm368509edq.89.2020.04.13.03.11.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 03:11:31 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id x4so8873778wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:11:31 -0700 (PDT)
X-Received: by 2002:a7b:c927:: with SMTP id h7mr17717288wml.122.1586772691230;
 Mon, 13 Apr 2020 03:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200413095457.1176754-1-jernej.skrabec@siol.net>
In-Reply-To: <20200413095457.1176754-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 13 Apr 2020 18:11:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v65qetxxVX1yoCjyduM4zRTyF3YKX1g9CuaHZkF_Z+AKQg@mail.gmail.com>
Message-ID: <CAGb2v65qetxxVX1yoCjyduM4zRTyF3YKX1g9CuaHZkF_Z+AKQg@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: hdmi ddc clk: Fix size of m divider
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 5:55 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> m divider in DDC clock register is 4 bits wide. Fix that.
>
> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
