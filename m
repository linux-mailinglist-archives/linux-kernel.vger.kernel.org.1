Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D29283756
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJEOIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgJEOIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:08:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55145C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:08:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w11so11063312lfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q/zdfYEifwQYC1tCHHSSSZhx/UYtdSVO8Lzn1xEk2s=;
        b=HUdALV59wtUBoJ6qxMJ35CEWIX+kDFGUqyqa0JuG7XefbPovQk/QdtJLMynscuYes1
         cm6rmsiYvFDdhiI7XMA4omMGULLYDlVlqO3o71GskjCJOngVweiAuhTUNnaSrQ3dUb5M
         0emqz/GMzEqPS+vJ4moe08uS/AYC2ud+RZvHokZdbb/Ff7kZeJlLTumb5lubX8WWat16
         lr79k6sez9K77pKHdQRtI9Chb8dYmd/1Q/mi+AMj15wfbwpFkqVzAcLfOwtKElboKx6F
         MaudUe6y7wAcHNU/P5DaX12P3+X9GpOimUzi5cXK1hkF5VXwryRHLfgiCMQ/7mJz6UbJ
         Zuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q/zdfYEifwQYC1tCHHSSSZhx/UYtdSVO8Lzn1xEk2s=;
        b=qwpDIeFQ04sNJx/KxkvMW4gYvEKmmOSuYfBWQ88+UyNQhId132W6qDm2+kif2PSU0A
         CQhnjDevU6AsvDdb1riD+PAFCNc2hRDC02d0o6o75F5g4yov3cclHnb8hV0sHboGRczz
         kSw6OWYD/jpgmS2e2uwADDT4fT8SwIDshE4XSD0dE2I9UvIUZz2SXzTLxp97ialsx71d
         tfFaIBcd9HI1CT2iH9pvl9JVlfk0VhHAqd4DO92XpOrqNRS1FUVVX3R0PMEbZt5hgX/W
         I/MB6yWhJK0q5rFfDydj57dW5FvPlHcO6fRlPZFlQpkpLyliekc9q6stphLfwvaU2WvP
         bgIw==
X-Gm-Message-State: AOAM533AHoaalFmmc5wKv9clUQcJf88pmOXjMbiwppsp7entNhcy+o00
        /Bpc9aVKcfarxhKMZHogVbxB7SiOoIF1urM3/azItHoFGbZQZQ==
X-Google-Smtp-Source: ABdhPJxkJYiXlHS/tZKafFAGQmDTcC4D+vwZudITpZIRxWhyG5FyXFCr7ARBvDoGTxXlfBl1KTeBS1r7cukUXIYqVgY=
X-Received: by 2002:a19:cb12:: with SMTP id b18mr6308085lfg.417.1601906895743;
 Mon, 05 Oct 2020 07:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201003063143.13093-1-foxhlchen@gmail.com> <ca694fc8-5f1b-ebf0-b891-c9a20225704f@redhat.com>
In-Reply-To: <ca694fc8-5f1b-ebf0-b891-c9a20225704f@redhat.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 5 Oct 2020 22:08:04 +0800
Message-ID: <CAC2o3D+X48sR4kFi9nS_atpTuSRWDnX92RD3uCUeh9AHXGnaNw@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH] gfs2: gfs2_read_sb: put gfs2_assert
 inside the loop
To:     Andrew Price <anprice@redhat.com>
Cc:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 9:23 PM Andrew Price <anprice@redhat.com> wrote:
>
> On 03/10/2020 07:31, Fox Chen wrote:
> > for (x = 2;; x++) {
> >          ...
> >          gfs2_assert(sdp, x <= GFS2_MAX_META_HEIGHT);  <--- after
> >          ...
> >          if (d != sdp->sd_heightsize[x - 1] || m)
> >                  break;
> >          sdp->sd_heightsize[x] = space;
> > }
> >
> > sdp->sd_max_height = x
> > gfs2_assert(sdp, sdp->sd_max_height <= GFS2_MAX_META_HEIGHT) <--- before
> >
> > Before this patch, gfs2_assert is put outside of the loop of
> > sdp->sd_heightsize[x] calculation. When something goes wrong,
>
> So this looks related to one of the recent syzbot reports, where the
> "something goes wrong" is the block size in the on-disk superblock was
> zeroed and that leads eventually to this out-of-bounds write. The
> correct fix in that case would be to add a validity check for the block
> size in gfs2_check_sb().
>

Yes, I saw this bug from the syzbot report and I though instead of
KASAN gfs2_assert should be able to catch it so I proposed this patch.
:)

thank you both for your comments.


fox
