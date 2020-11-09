Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17A72AC2D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgKIRu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:50:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgKIRuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604944254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXvEm51EQgg6d/6+RsO689mFrQ77idUd378cb1GQATE=;
        b=Kiiv8fc1wf2KRtX+UsNdzx0+N2ftGCLAl0ZfHSmpV98CYQ/TSibcMI/0JwnvawXVnGJ+k2
        p4rD8WBOVRydwjhmLHSdJAW4W2kASZ9SeSP5aert+R1VsRtjT9V45f3UjMufRMCqlKrDyH
        Gaw3F3LyX9B8THOgklAixaHezJxKK30=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-b0TdEbfqNHycOdiAn1l3mg-1; Mon, 09 Nov 2020 12:50:52 -0500
X-MC-Unique: b0TdEbfqNHycOdiAn1l3mg-1
Received: by mail-qv1-f69.google.com with SMTP id ca17so2721836qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=YXvEm51EQgg6d/6+RsO689mFrQ77idUd378cb1GQATE=;
        b=SjQp2JbXO4401YSks7JC4tE4AEb6ybqQI7UWahrx1TtQHU9i1j32s3XZmfXMH4Kjvz
         PLI98mlA3OF5iWks6ueFEXuYMm0jqWbdTv6Srm0p2BjtmjzrWxA5U+kGD8/nabsCyPhg
         0C8+avcyjAy3UpKiBZNtzH+rT6T8sCnGvzQGtZVVgQvzVUnNasOSpoo5oT0Rth4J8HkA
         xzpRIuxZjiT1OiZ2XkZZXmUhZYzPSZPHndFP8p8z21zFo8sSv54uK4Lvlj4Br6sQxeov
         K8FKGgC7xQRJ5uhgdIDhBK1X4WnPFn0BbR2fjvlTH0khZV6HOr0SpHvup8kQbeoiWMzT
         TLAA==
X-Gm-Message-State: AOAM530mE9lcbvVEeGvd+q0Of/371zhVIU4z4qI0ZP9rUZDNAWbZDWnv
        6RUm+Ec1vahMA0lkGBDdmUVcNEz0vDTQTNzTAj6VAy0xQTqDJN0dP1jiGuhYAHVLbZdkeWQOxl6
        YGmQN/fBpUY/kkuRSz3K5ILTT
X-Received: by 2002:ac8:4252:: with SMTP id r18mr14156767qtm.26.1604944250807;
        Mon, 09 Nov 2020 09:50:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkt6WIewMuarxBeEODneqDLaawRUL0XSwbyfZf8lRXCXsVRCL6e/nhUFsB6to/IO6Ub1UZ5w==
X-Received: by 2002:ac8:4252:: with SMTP id r18mr14156755qtm.26.1604944250643;
        Mon, 09 Nov 2020 09:50:50 -0800 (PST)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id j10sm6212957qtq.59.2020.11.09.09.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:50:49 -0800 (PST)
Message-ID: <ea2450953182320516f8e8bf857625c58a18f584.camel@redhat.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
From:   Lyude Paul <lyude@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>
Date:   Mon, 09 Nov 2020 12:50:48 -0500
In-Reply-To: <20201109115209.rwhoe4zttaxirx6c@box>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
         <20201103222013.hypmzlq7uuqufe76@box>
         <71dc852e52bfeafc8c03a6fa3cd5f3cdd4eb6609.camel@redhat.com>
         <20201109115209.rwhoe4zttaxirx6c@box>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the patches you sent is on my TODO list for this week at least as a
priority, although I really would have hoped that someone from Intel would
have looked by now since it's a regression on their end.

Gentle ping to Vsyrjala and Imre

On Mon, 2020-11-09 at 14:52 +0300, Kirill A. Shutemov wrote:
> On Wed, Nov 04, 2020 at 04:58:14PM -0500, Lyude Paul wrote:
> > ACK, I will send out a patch for this asap
> 
> Any update. AFAICS, v5.10-rc3 is still buggy.
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

