Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6112A04DC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgJ3L6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgJ3L6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:58:51 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EFBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:58:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t25so8164991ejd.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=es3W41hUxdDg86pFUPaiLWzXfxDdY/Ymsd0P2JgEFGo=;
        b=hZHsNXwCnLH3/hTG8xsUeiLZro+ZFgot6WaiRq6UequqNI9tv7Vg5BHmMULLNrDtxX
         StSru51lI1cyWLUg55nOXG2qO7armb1lk0UIm9kpz3p2I993FySrJmdffVT1Or6UsZCZ
         yPoU1e1Dz0KZyhtOGGEUSo4b0j9qTiZWw4iLE/NYEkJZS2o5aVp8pmx/jOCxr2Emc395
         gYezdSj/zntBomqcGTLSRALS6l4IkwxIuOTWMHkMHxeqFvJfIh5s2CeHPkAatjbUGkRa
         AfXhFxmgAyDrD8k0duE3DHigGOdRyuln7iRcnErs+/Z5m2sY2ACe7ChqJALH7gsSpufS
         qeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=es3W41hUxdDg86pFUPaiLWzXfxDdY/Ymsd0P2JgEFGo=;
        b=tmtm+JDn4wHE6IGlKFHWCMY6RX3QuRINNl+eKj42nq2lQuAkxkO47hmCx6ahjza3aY
         PT8s0I1WAwJmyqktT4cvuMTKaBlSseSHdGfLm+Yfb7UFfkM77C9Qs60Y70zSt/yIDF4x
         /DW0eQedR85WRfTmt7uSm9e3n4H5L3QdWEACWzixzy+zfRTsSzilQGvJ+Nu4IR+aFKVv
         oqUmufxHE80ya53o/zkO3D4FrrCZGbbp97gtFXbFFiYVJyoady0D6M3ymfz1/WsRwGna
         CaEeT74tSmo9LRDz/6EFoOUReQ6neKvzGtlgwk2H6vsvASaCibBxnyvhwWto7/M7A3YL
         44mQ==
X-Gm-Message-State: AOAM531Z1epPtLkxgmaKlhbmiE3ezcsxTwFB1aOhVP/O2h9e5FmuwhKi
        IBFiMpqs7jI+8cq/p6zfDmI=
X-Google-Smtp-Source: ABdhPJzky4bcRdmCiAHwi7ZjnIhj4MyNII8wAYI1joF/7yR+oooejVL+zdMXPs4WUyFkOx6S7uVmdw==
X-Received: by 2002:a17:906:6a57:: with SMTP id n23mr2155448ejs.315.1604059129670;
        Fri, 30 Oct 2020 04:58:49 -0700 (PDT)
Received: from felia ([2001:16b8:2d02:400:25af:1ff4:dc3:177c])
        by smtp.gmail.com with ESMTPSA id u13sm2868017ejj.4.2020.10.30.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:58:49 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 30 Oct 2020 12:58:47 +0100 (CET)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        yashsri421@gmail.com
Subject: Re: [PATCH] checkpatch: improve handling of email comments
In-Reply-To: <9d5c8699f94481ab5bf2d37348199ca1d6343c8b.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2010301255460.16621@felia>
References: <20201030090704.40533-1-dwaipayanray1@gmail.com> <9d5c8699f94481ab5bf2d37348199ca1d6343c8b.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Oct 2020, Joe Perches wrote:

> On Fri, 2020-10-30 at 14:37 +0530, Dwaipayan Ray wrote:
> > checkpatch has limited support for parsing email comments. It only
> > support single name comments or single after address comments.
> > Whereas, RFC 5322 specifies that comments can be inserted in
> > between any tokens of the email fields.
> > 
> > Improve comment parsing mechanism in checkpatch.
> > 
> > What is handled now:
> > 
> > - Multiple name/address comments
> > - Comments anywhere in between name/address
> > - Nested comments like (John (Doe))
> >
> > A brief analysis of checkpatch output on v5.0..v5.7 showed that
> > after these modifications, the number of BAD_SIGN_OFF warnings
> > came down from 2944 to 1424, and FROM_SIGN_OFF_MISMATCH came
> > down from 2366 to 2330.
> > 
> > So, a total of 1556 false positives were resolved in total.
> 
> A mere reduction in messages emitted isn't necessarily good.
>

Agree. That is why I also went through the list of those warnings.

I could not spot any obvious true positive among the reduced ones.
 
> Please send me privately a complete list of these nominally
> false positive messages that are no longer emitted.
> 
> I believe one of the relatively common incorrect messages is
> for the cc: <stable@vger.kernel.org> where a version number is
> continued on the same line after a #.
> 
> CC: stable@vger.kernel.org # for versions x.y.z and above
>

That was one, another common pattern was just quotes put inconsistently at 
different places.

Lukas
