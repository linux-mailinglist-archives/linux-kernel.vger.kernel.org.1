Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6147926BDED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgIPH2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgIPH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600241287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SB1wk+nAtqosRYctKp+oitj3bhHJSKNwOnYr1XT96tY=;
        b=KE6F/EhjnjbP7jF6WF2jHACSIgR7Py3TkikM7phTsvG9v4nxUrMLBa/eEPXEM8lqZA7jc8
        YgzBVMcAsBn2KjDOfiuPl2Pg7U28BT6ufPP8Lqz5xVkgx65kMPOMqqbHgqsbYLbKrztmGr
        EFcb/JWxDI2upjKjlnJXvKFXnR8I+sk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-Y1gvs7LFN9WyDQAv5TKRww-1; Wed, 16 Sep 2020 03:28:06 -0400
X-MC-Unique: Y1gvs7LFN9WyDQAv5TKRww-1
Received: by mail-wm1-f71.google.com with SMTP id m125so673200wmm.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SB1wk+nAtqosRYctKp+oitj3bhHJSKNwOnYr1XT96tY=;
        b=OxJaYU1bCOD2g9lZC7G/30leR8tqrkRlDLO5jE5doYSeCVIQaXjl54/LkYTt8+Nqn2
         q/KPocueI3slNCMzm7aH2+3i4E3BP/35txCzM9oa/LRsLSD4SxKSHucrBauoDfgRQjPo
         1Y9oPZjuG+pxuJEIgLPG+nE2BA11LQ7HfJevxxkaLEEJwFvowVDJ/kvSBgpO0eNhPXOV
         ZAPDTkmOE2KJXm6aQylqRL/q/vFhv8yvV1Oy1+OnNOYyAEABT2krc3GyczggRH1ZC5So
         wx8Cy3BJpTsljmWxs50h2OU9TdKEvny0+q/0p/TH7dpKRLljM2xTfC4P8CgpbuINVVxA
         +kCQ==
X-Gm-Message-State: AOAM533vT3lKwkI4majt8gn5KEngm96qNom0TF+kPj7URNgwuo2hMieS
        msh/zqSpiTZroPhBpi3rA49yFUHpjPadsmysjM6ZN/qGZ07INFiJ45jQxY3H2KK7tSVUur1KVhL
        SN4KMYbFoT6g8Tr7u0g4/DJbLW3IuiyapiU265FSE
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr3129290wmh.152.1600241284934;
        Wed, 16 Sep 2020 00:28:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8chO+fK9Z/WXz8qpzx6meYT9jxTImOy+DgfTD3XpNwRa1gka/HWHjUkBSa4jYpi/iNjHpQA43wCxcWKmF5LE=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr3129278wmh.152.1600241284750;
 Wed, 16 Sep 2020 00:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200916025021.3992575-1-liushixin2@huawei.com>
In-Reply-To: <20200916025021.3992575-1-liushixin2@huawei.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 16 Sep 2020 09:27:53 +0200
Message-ID: <CAHc6FU4G25w6-YUHKObC_ASdUPWG-Psg6+ODzMPfqr+VYwT3Uw@mail.gmail.com>
Subject: Re: [PATCH -next] gfs2: convert to use DEFINE_SEQ_ATTRIBUTE macro
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liu,

On Wed, Sep 16, 2020 at 4:44 AM Liu Shixin <liushixin2@huawei.com> wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

I've pushed this to for-next.

Thanks,
Andreas

