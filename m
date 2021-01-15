Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169D12F88BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbhAOWqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhAOWqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:46:14 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BDC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:45:34 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id t6so5460204plq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Ggrkqc0MFDFUf3AJp+BE9Rf6dLa132gHaYToVpUuPTs=;
        b=aO//dEJ1LmgI6aJD4qkn6oqxygDAXaWgsG+7pvvcEzOfAf9w2b5LtTKTqY3JqQlpv7
         wOasWvjd4qPTXY7hwqsGXIufHZrEnr0e6bjqpF3Z9hj8dafUt/TH4NGc6Azcuhu98dmk
         uT5i/UT1ZTDEfKX3KU1L1YsfzL2XyTfzFZNmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Ggrkqc0MFDFUf3AJp+BE9Rf6dLa132gHaYToVpUuPTs=;
        b=BFRi4E+gffpQQcmNOXoGzalesg26JTBkiege0K0UJxo4wyEfBHqLFVX2eNcutUjZ10
         sdmuTr6CDHoBoTRTa8W3LlLM5Nr7TcRcKgRNy/fTU+7OaGqm3Z8dK/FnuzEZ5JQqq0mu
         au/mxzzwWWxSSDZeFxN8NG1q+g/JY2CL3a6A7FvPGa5VJlX8ObZilHLnl9394+cqoBca
         sRIy+ROSXmFeErfe/RPAIezj9uhO5fct0/UFyqvGG5GPntH4uwCt4ZpMVjkZ1IbxwK80
         BybKmKai1noK0keBT39hMlPWc4JWXJ87JcIiRKbqvaG6z0CoIPof+EqcIyNsm7SkC1+o
         tDIQ==
X-Gm-Message-State: AOAM530DrQ2eUYzsXKFsCnLWB0k8SVq8Ed1wxhrOPZbiTAflxMw0UyZt
        07+jiWmN1j7XpwaI9n6TkawlVA==
X-Google-Smtp-Source: ABdhPJxwCbBZqtMeFDPtBSLJv54kwoyFN9oWvYqIR/oXcsvUj7Atl093Kep1uhNAUbP0GrMKZOT1Gg==
X-Received: by 2002:a17:90a:de13:: with SMTP id m19mr3240604pjv.171.1610750733931;
        Fri, 15 Jan 2021 14:45:33 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l8sm5824479pjn.46.2021.01.15.14.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:45:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <X/dlKKeAHU/Ab+VD@google.com>
References: <20201205004709.3126266-1-swboyd@chromium.org> <CAD=FV=XjzBLTPMqOf1NK0pjXiZWrLT227nksxhMqaFG6GxAqjQ@mail.gmail.com> <X/ZwRqJFJ9BY4Z3z@google.com> <CAD=FV=VmNQDSZFT3vaJ64DYyGqoE39uig581ZmaX0s-Y1U_CTw@mail.gmail.com> <X/dlKKeAHU/Ab+VD@google.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Add support for a front proximity switch
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, open list:
        HID CORE LAYER <linux-input@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jan 2021 14:45:31 -0800
Message-ID: <161075073197.3661239.6820430732230306799@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2021-01-07 11:46:48)
>=20
> Yes, I understand that on some devices the proximity sensors are not
> true sensors but rather on/off signals, potentially derived from a
> multitude of sources. However there is still a benefit in exposing them
> as IIO proximity devices with limited reporting representing
> [near, infinity] range/values. This will mean that userspace needs to
> monitor only one set of devices (IIO) instead of both IIO and input, and
> will not require constantly expanding EV_SW set to account for
> ever-growing number of proximity sensors (lap, palm, general presence,
> etc).

Ok, no problem. I think I'll have to spin up a small driver to handle
this as an IIO proximity device and then register the IIO child device
from the cros ec driver. Let me see how that goes.
