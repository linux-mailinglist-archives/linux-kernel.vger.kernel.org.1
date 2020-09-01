Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4999258F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 15:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgIAN2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgIAN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:27:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D6C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 06:26:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so1519055wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CNABcpASJeKoKft4PG4FvpewpijHWWDk2sidoyW6heM=;
        b=j4QVHRpw4GzJKBjxvLbpZVenJ40TC8oXokiCIJpYyNS4gt1CZacOxXPxYVUPI+837r
         HxCvNyadvqQ/QRyp4sYjxy+1jcMfW4tL2nJ+mBuDTSyF6V4hm8dMGWErFM7WuWKliuos
         Ii4MIPD+rHfy/HsCl6NgbsWz/2pfoUUa4x8WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=CNABcpASJeKoKft4PG4FvpewpijHWWDk2sidoyW6heM=;
        b=CPpIEtqrxidvvuKiZmHwDa2m/9CPHz3lRX02fT0TmRatdcTqRp2SbA5HrJXIppVRdH
         L7sOZCy0HkWtgjVI2e4gBkhcCYl2blVz0+GVbJ5HTu4u3Sr7LqQzmPEvPVYOC+OUrBUs
         rBLtE4+8+1P74zbOdQUjPFaGffktFXwh27/a9JSvSY4h/KBw9VXD7+J13orc54k4xM3S
         vfiovH2gknhhw2N6L76MwNVGJEtVEO//IyNUiLu0xQwrlV32RMEpVJruUWs6lP+XrSHO
         /saGFv8mX7v+2mHWphTdTz8GaHOkZEtbxXBsuIRWfRV8b2eHpkUITiS38eghdneRnkjG
         D95A==
X-Gm-Message-State: AOAM533NsYyp6WChTDbUm9EQ7s3n+pivK0kmE6cZeutxFFVNS2AHb6ha
        vtVi+jZ3pl6bYHU7busXgpg8cw==
X-Google-Smtp-Source: ABdhPJz/tROheQMCb+pApG2Lu/+Is30f61BJWt+eoItPVyJcy/+r2iL4m5NBLt+OOKw+9cBOY3dI/A==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr1852446wrw.261.1598966818495;
        Tue, 01 Sep 2020 06:26:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w15sm2402549wro.46.2020.09.01.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 06:26:57 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:26:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Simon Ser <contact@emersion.fr>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Sidong Yang <realwakka@gmail.com>
Subject: Re: [PATCH] drm/vkms: add support for gamma_set interface
Message-ID: <20200901132656.GD2352366@phenom.ffwll.local>
Mail-Followup-To: Simon Ser <contact@emersion.fr>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Sidong Yang <realwakka@gmail.com>
References: <20200829140647.7626-1-realwakka@gmail.com>
 <UeJwFKvmNgKdZY_icN0-nrFly9R1vbzaMZ-TiyxIIPBcdl278uZsK6YdTTdRl6rFukBAmN-eyCFpnfsIB-El9QpyYiutdcpgJg64n4tsRRc=@emersion.fr>
 <20200831133858.GA9280@realwakka>
 <20200831134852.GY6112@intel.com>
 <C7EgdPUBX9nRTKx9kkGIZijd0yGMOLEtXOwa2jvk-rKtprmNZKSDP-Jos7mYU88DOQYiXJBnz0_D2FAQ1x7jCwLcR-cmZtzCc5cLsJqyDCk=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C7EgdPUBX9nRTKx9kkGIZijd0yGMOLEtXOwa2jvk-rKtprmNZKSDP-Jos7mYU88DOQYiXJBnz0_D2FAQ1x7jCwLcR-cmZtzCc5cLsJqyDCk=@emersion.fr>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:57:37AM +0000, Simon Ser wrote:
> On Monday, August 31, 2020 3:48 PM, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> 
> > > > It doesn't seem like this IGT test's goal is to exercise support for
> > > > gamma LUTs. Does the test just tries to reset the gamma LUT to linear?
> > > > If so, I think the IGT test should be fixed to ignore "I don't support
> > > > gamma" errors.
> > >
> > > It seems like that IGT test pixel-format is to make gamma lut like below.
> > > for (i = 0; i < lut_size; i++)
> > > lut[i] = (i * 0xffff / (lut_size - 1)) & mask;
> > > And set this table to drm driver. and test begins. It's the test about pixel
> > > format. I think you're right. It's not about gamma lut.
> >
> > The point of the gamma LUT stuff in the pixel format test is to throw
> > away a bunch of the lsbs so that the test passes when the result is
> > "close enough" to the 8bpc RGB reference image. Without it we would
> > never get a crc match when testing non-8bpc or YCbCr formats.
> 
> OK, that makes sense. Would it be sensible to:
> 
> - Don't set gamma if the pixel format being tested is 8bpc

Hm not sure what 8bpc format you mean here, because we have C8 (needs
gamma table or doesn't work) and the 8b greyscale one with the R8 one. If
you ask for legacy 8bpc you get C8.


> - Make the test skip if the pixel format is >8bpc and gamma isn't
>   supported

Yeah the test should skip if gamma isn't there.
-Daniel

> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
