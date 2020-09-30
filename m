Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104AD27E961
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgI3NUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:20:23 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgI3NUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:20:22 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M4rD7-1kNKeA24vv-001yeT for <linux-kernel@vger.kernel.org>; Wed, 30 Sep
 2020 15:20:21 +0200
Received: by mail-qv1-f42.google.com with SMTP id cv8so830902qvb.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:20:21 -0700 (PDT)
X-Gm-Message-State: AOAM530vL4VNlVivY2WtxQP/Iu5mLcdPQqlvTMifWthT+wr61qhzGo0M
        ZvKsM0RZAKXFsmgL4MPUPqS8PeZUPCcpdrwMnHY=
X-Google-Smtp-Source: ABdhPJyDD7XqKSISPEq+ZAQ/7Y/ijdd+XQAuPP+SpSDVf0jZHLaRmnqb8VjxEGx8vctaJKn/vQMALa24lbFwt//5tn4=
X-Received: by 2002:a0c:916d:: with SMTP id q100mr2254292qvq.8.1601472020378;
 Wed, 30 Sep 2020 06:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200930121007.GA1615300@kroah.com>
In-Reply-To: <20200930121007.GA1615300@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Sep 2020 15:19:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3FX=uuqG6KW7b4Zsh0xiCea_6B2sE3DChQx-e8EUF43g@mail.gmail.com>
Message-ID: <CAK8P3a3FX=uuqG6KW7b4Zsh0xiCea_6B2sE3DChQx-e8EUF43g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: exclude char maintainers from things they do
 not maintain
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jnp25O1RL+zmcG0N65qOt4xQG26iEaiw6BvelKW7g7XYkY9MFwM
 Aqh1UIAkGK6VQztV4qXtQm2pPGNeJyESd9fdm9xUgTSysmJPvMbz1k4ZiL/SDcb7rR92s1w
 y0BYWvhCCKh9uc+KTSm5rzoAvR6f1SyYnOsEfk4/ZznmJ3e3FxtwZMfVD4fAJXjFnTkfeFa
 ERgtsPwxJRI5Je/2QBOEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uT7a6z8T670=:BbnYoZ9nyZLGmCTSKFXnSK
 1v9LikRB/V1a0Lxmg6HvRVOd0t3DJ3JFDM4XkhqfhJiP2o5KNDPZE4zZmzeA30Y0bn3nr85Gy
 kBCQVeoxrdVliehFsId4SrctAZ/XwgP2ExcKMd61JXzCoeW5hM98lsq3jt8gdoaYS8DGo+MOM
 J/4kGn9U2naCk+ENmZfuYX9h+sk/Z77v3E5oSWRJf+H//g2MOrthuccfgcddvT5m46BM67VXD
 O2ndDMsf0EmplTl+mPFpK/swFd1NgjRhxowc2IrTZzUck+Cv4473How4ZMud4W4RSjta0gYu8
 33h9V4wJmXVm5XU1O+VexlFgRvv2fNT2IAG6oyX8w5xhXeb937YGTcnCrYyhTHslwGl5Kq0b8
 z+SwnkQ5DZBRzA4K9Uu0bJaRWlSbsiwJN0gYZdQ7rxyPbpRXi0iyCmbPfo3+Mt7Es0wGLksby
 7pwmebAjNjApdzpwPcBVkCWnicYvCohyn1DQX4JkvcS4NUrQkZK8vWFjNQGmCU1vAUzdb1VJU
 6rOLSUjOpB29YlR6V8tUjoUiynE/zI9c9Pu6N5EvttLfl18Mk5Bayt8B34ApYdS2a3yLPj0KT
 6R7Hoa4+6wPpe3WRgWktVoc0xV8bEltnNNbdaJxxMi3sz8Uf4eQOdZ8NODmKPJDDfsvb9Hn0/
 Yc3/DzEeo/xM9Z8lIjf9krnCDmia6MW+okgTsznbdGUj4YixIVfvD1g/Ko2coADyYMuBZNmji
 wkPKNJYua2h4HGJBkjx1lfu6VKGVEanc9fanxOfh9z6Rlhutty0KZln9J1y9lV2uLiIRKOqvY
 o4E1HWukT0dgWsxlrrpTr3gN9N1W0sjRfOcjUKm0JhmgBYxfemXa44/ThKvHapaPDsJJ25Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 2:10 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are a number of subdirectories and files in drivers/char/ that
> have their own maintainers and developers and ways of getting patches to
> Linus.  This includes random.c, IPMI, hardware random drivers, TPM
> drivers, and agp drivers.  Instead of sending those patches to Arnd and
> myself, who can't do anything with them, send them to the proper
> developers instead.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Good idea,

Acked-by: Arnd Bergmann <arnd@arndb.de>
