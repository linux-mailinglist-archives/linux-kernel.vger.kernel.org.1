Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D372AC506
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgKITdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:33:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729899AbgKITdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604950401;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cp1sLqcPnHvx8voy0UI3JLO2wJ3RzttsJAjkyMxuFgM=;
        b=GOi8GtT39h8emIkXtq8U/ocVQe5kgcyM97eTuXMWqx3acPa8mohQax0lV7BwOxoSVILk96
        ixBAg0o3+59ghQQSwGm9Xk/dxJLUntBS8LUymc/tNy0vLa+Ss89TTYxh4D+sDSE9vOfbBl
        NzRlVE5M19zKt6UU4RyCWJE9I7HjuZ8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-de1zDOCJMtuPzyAPqw1XLw-1; Mon, 09 Nov 2020 14:33:17 -0500
X-MC-Unique: de1zDOCJMtuPzyAPqw1XLw-1
Received: by mail-qt1-f200.google.com with SMTP id z14so1528418qto.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Cp1sLqcPnHvx8voy0UI3JLO2wJ3RzttsJAjkyMxuFgM=;
        b=n9o1qKh3BNIdaXO4mIkOAMabXyWS5DnYyK1zwArvW0+pIwBXuyAZa5Aaqur1OF+7IJ
         p/udgItUnlHfarcbqpAFiLts4ZINxLOVK4boMAdbvjc91tfNvjjF/ONIyw5+cc+aKqP6
         OV4xuCkbV1MwVdzaXHfoU774rztBMD+97fhUzLK1j6wSIMaLx8UBRHfYe1OMjTIxxZSm
         UWbBIuz95J8ejsxHEnTMhUazWBG+tya5gr6Lrk8OHrp7N9GAiquBVd8MXxBw9NIohM+j
         a132JEdPKyP96MQisCzZrhdHmZl+St99/HDH9W99fLvf+L/idlo4HHdNE0G4VukzsWHv
         3hIA==
X-Gm-Message-State: AOAM530YmWNbWgODb2qkITPssO0Q9Qeo4vqaTAteRS+50tRs/hj7W8ef
        SmVW1vNFwm9/LZF/RepWu4XDvuRb6lJSLkiPRQbv+6jrpc26bjEijPE2PRpIS/4J67jTG+mLEEU
        Ic4T+L61loWuCQv6AuF3YBig0
X-Received: by 2002:a05:622a:4e:: with SMTP id y14mr6931397qtw.392.1604950397070;
        Mon, 09 Nov 2020 11:33:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBzoLN71OPYWBC2+sK+xP8k2BFPCToq9OBiIJUih1rKRmf1rkLW6cptsiMJnhXPMeBVyMSrg==
X-Received: by 2002:a05:622a:4e:: with SMTP id y14mr6931371qtw.392.1604950396799;
        Mon, 09 Nov 2020 11:33:16 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f128sm6901967qkj.48.2020.11.09.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:33:16 -0800 (PST)
Message-ID: <1c5618fa18445a3951bd86f915f3d93aec81b354.camel@redhat.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Imre Deak <imre.deak@intel.com>
Date:   Mon, 09 Nov 2020 14:33:14 -0500
In-Reply-To: <20201109190808.GN6112@intel.com>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
         <20201103222013.hypmzlq7uuqufe76@box>
         <71dc852e52bfeafc8c03a6fa3cd5f3cdd4eb6609.camel@redhat.com>
         <20201109115209.rwhoe4zttaxirx6c@box>
         <ea2450953182320516f8e8bf857625c58a18f584.camel@redhat.com>
         <20201109190808.GN6112@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

whoops, you can ignore this actually - I got this mixed up with an Intel issue I
was looking at, this is actually a nouveau issue and you guys don't need to look
at this :)

Kirill-I'll get to this asap, but I've got some other stuff on my plate to go
through first. Could you open up a bug on gitlab in the mean time?

On Mon, 2020-11-09 at 21:08 +0200, Ville Syrjälä wrote:
> On Mon, Nov 09, 2020 at 12:50:48PM -0500, Lyude Paul wrote:
> > Looking at the patches you sent is on my TODO list for this week at least as
> > a
> > priority, although I really would have hoped that someone from Intel would
> > have looked by now since it's a regression on their end.
> 
> What regression are you talking about?
> 
> > 
> > Gentle ping to Vsyrjala and Imre
> > 
> > On Mon, 2020-11-09 at 14:52 +0300, Kirill A. Shutemov wrote:
> > > On Wed, Nov 04, 2020 at 04:58:14PM -0500, Lyude Paul wrote:
> > > > ACK, I will send out a patch for this asap
> > > 
> > > Any update. AFAICS, v5.10-rc3 is still buggy.
> > > 
> > 
> > -- 
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

