Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8327E26E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgI3HRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:17:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54030C061755;
        Wed, 30 Sep 2020 00:17:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so380868pjd.3;
        Wed, 30 Sep 2020 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HvB5WWDeCpx4UxR7469lckPwvo+OJ9mvkcjL6Dnh5Es=;
        b=cz3y20djppMM1e+O0NQd3T9TUu175fFor7dMRlKW8evtdkP9ij7Mv6pVrnc65HDa5l
         IiQRZrbfI2PBy4HxXsqRJwldR8nks5NWfJ7JDpt3gOenJzSo+0ku7py9qj1pfGDgDgX9
         hIZg1E1/NuZhV5AvDsOwcnvQZpQaUcJ7tyc2gAtbz6zH961mwlViPt3GDRUMxyq3F/EU
         DPIFjE/6lkd37HnMu//PZ7awQl3cpq9S6UKS+SZci6j7avpbUUcsL2mV9dbxTjLHr+0N
         sddd6G2EBO++3ivQbQQe+CGLjpIAzIdbR4z9UbN9RgsfAt1zFPsWV4bfRI0x37hDid9d
         /raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvB5WWDeCpx4UxR7469lckPwvo+OJ9mvkcjL6Dnh5Es=;
        b=Lv2Zh5OKtqdtrAOyKW55BENq4OzbIp64/vvwrIbubLIz9UifoiChZ88Xyjn8JSlb+f
         i43Ipe8/99jJaXqqW2CZ885LaPmN/BTzehszycMUuq3hqs4869Hifb612RFOhAdcZunY
         6f4fcqNdvL1IUnev+h9ccsbKVUigiP1VIy6z/WDOO4RnhdNrFJmu/Q2L/8T2vNaoAipk
         YCy4b53V3GI5FX8851kt9sCkP/g4+kvRckELbKcRCkl/8a4ZafhV/pHOQmkZ9WcqctvS
         K++YVEaNoCtR+SoOgE/P3YocElkiPExcJLtt9ryyE5k2O+xR+QIKLv7Hkc2Oq6V9bHV4
         +TIw==
X-Gm-Message-State: AOAM530J5qDrSDZzsOZXD7xx2hgamX6doWuG0k9gAup/9AVEzZSwOL4C
        jvMTbNzD9N0dKRPojxLc/w==
X-Google-Smtp-Source: ABdhPJwwhqS/oKgZ2gCgTtB/SwDO9Ox+IW1ZuQUaTukVj7RoNvgQyRu6dyqlZGMOEx3c95YBXvzTtA==
X-Received: by 2002:a17:90a:9704:: with SMTP id x4mr1361295pjo.20.1601450221896;
        Wed, 30 Sep 2020 00:17:01 -0700 (PDT)
Received: from PWN ([161.117.41.183])
        by smtp.gmail.com with ESMTPSA id l10sm1034278pgp.25.2020.09.30.00.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 00:17:01 -0700 (PDT)
Date:   Wed, 30 Sep 2020 03:16:52 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200930071652.GA1152625@PWN>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200929123420.GA1143575@PWN>
 <7d341242-9612-d0ee-4b79-e93882fad73f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d341242-9612-d0ee-4b79-e93882fad73f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:26:52AM +0200, Jiri Slaby wrote:
> On 29. 09. 20, 14:34, Peilin Ye wrote:
> > the work in general? I couldn't think of how do we clean up subsystems
> > one by one, while keeping a `console_font` in `struct vc_data`.
> 
> Hi,
> 
> feel free to change struct vc_data's content as you need, of course.
> Only the UAPI _definitions_ have to be preserved (like struct console_font).

Ah, I see. Thank you for the reminder!

Peilin Ye

