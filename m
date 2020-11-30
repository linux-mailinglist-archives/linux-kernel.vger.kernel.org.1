Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320E82C8522
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgK3N2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3N2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:28:47 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD13AC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:28:06 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x4so4742940pln.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tBT7i6z15AksCajz/wH/sGCs7nhPwPYnnS6VEGnjqwc=;
        b=Pq4W7wieVh9/9VBzkgb3rAk5lf5CKX7zOP+rb4tkV88PXU86gf55qRklf2ypKpH9Pb
         cOcYNnDuhIEPL9JCGHhc4U1Y1WiA1kUrhOFv6xkN0iF2ze4kSgzg/2z2VrWGclE5k2bI
         jB6tZjcYreCS8cq2BHsHYXBtjJwN3Qvycjs9F2aqdQf3FNtBgreDgHetPAQ7YmCKjEoU
         ygBeH6/gdR3Ee5dvEjyyLBMye8kQgvfuZ786CNTSL49FwcydwIBH9+9xskLdMA2H81Wh
         vUP3LgpiReWPOc3p0trL9Rk0/BpB5NwTyimr9TKHK9jZCnbtlPlZefONM81L4xe6hrV8
         WjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tBT7i6z15AksCajz/wH/sGCs7nhPwPYnnS6VEGnjqwc=;
        b=PasFoKn6uDnOt97Olt7zu0M6XlgFwKChVEjj667DbYYZ10r9kwQFdsT3+bmuOiKVVd
         0YOEIjd4ZKPql3unj7zksDHK7WmvaEDyghS3QDQ+jkrDo22wVVM6fVgT/4wCw9XG0OeA
         7PCpalUuXoIBkaFHdrNeZx8Y+uKqkz7MwL2Sb/FGQdJ54rU0P9MGF32gLiv7Pd8zVCLq
         l/1ZWxCUPTNDA02UJHuJVgqQKocd8/QgICFMtezcWbcw99mbe8yW56/XXWbLLKDIhic6
         TFB5UkMaAV/LtAEnfSUBsvbhnjsL8M0pW/jn7qI+tGIdvVgELL77+/SHNnOJB5JpDXcg
         69CQ==
X-Gm-Message-State: AOAM530ERRp6u+m/oiJFWx9lPIFPKHZMe/A7I0E3cBBSZTgosFuPb6YR
        o6qpHdOPMphAUiIeAMGnPGw=
X-Google-Smtp-Source: ABdhPJxr0bLuN51EKpIjkqUsyjjJVyH1G+JyGv6gsDiNq3zqjt8bzQ7Xxy/2FT/n/VY0mIK7gR/dqw==
X-Received: by 2002:a17:90a:3902:: with SMTP id y2mr26433534pjb.126.1606742886368;
        Mon, 30 Nov 2020 05:28:06 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id l8sm21939768pjq.22.2020.11.30.05.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:28:05 -0800 (PST)
Date:   Mon, 30 Nov 2020 22:28:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] posix_acl.h: define missing ACL functions on
 non-posix-acl build
Message-ID: <X8TzY0rotaSZ2FYv@jagdpanzerIV.localdomain>
References: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
 <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org>
 <X8Rj0s/Emv9Qmv3d@jagdpanzerIV.localdomain>
 <X8RkVIxou1D1YfEb@jagdpanzerIV.localdomain>
 <X8RpFo+5m1i4L5Gn@jagdpanzerIV.localdomain>
 <c96f60f4-f525-2957-6a8a-ae9e3288b04a@infradead.org>
 <CAHc6FU59uNEq4Xz8W7boG6y3+u3F1tz93RKSW+odM38rx37_9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU59uNEq4Xz8W7boG6y3+u3F1tz93RKSW+odM38rx37_9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (20/11/30 14:09), Andreas Gruenbacher wrote:
> 
> Sergey, what actual problem is your patch trying to solve? It sounds
> like this is either theoretical and pointless, or you're trying to
> build an external module that uses POSIX ACL functions that shouldn't
> be needed when CONFIG_FS_POSIX_ACL is disabled.

It's an external module, that OpenWRT folks build with !FS_POSIX_ACL.
It compiles just fine, but modprobe fails because there are several
exported ACL symbols that don't provide dummy definitions (which the
module in question didn't guard with ifdef-s).

> In the latter case, the external module will just end up including dead
> code, so the module should be fixed instead.

ifdef-s work. But since posix_acl.h already provides some dummy
definitions for exported symbols, I thought that that list can
be extended (become complete).

	-ss
