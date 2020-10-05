Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5D928374D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgJEOFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgJEOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:05:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2408C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:05:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so6105514wre.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rYgwu/tsb6hqZBI1Z2tL8xDFx5slTZgCuj1UmwV+264=;
        b=CTB3t9HGVokgEOA3jolJ7ACDLs2ngsZCF7EaI13IHHQzva/DwYCi/n9j6GSDldLMKA
         WdyH9vanMUZ96PtuSw2eGBuXWYDlRiN8d2rBC2cxzVO2sUIub0tdKaMY8SXiVum0DR6b
         7JYvH8fRACBp77gNIGx9YiphHbDGcHPRYoYR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rYgwu/tsb6hqZBI1Z2tL8xDFx5slTZgCuj1UmwV+264=;
        b=Hrg19DM4vjdQa5pVffH6ATCq1pYFPECly2jGToUFgjers8I2QBtj4kLSBaMLvGo/Ya
         Z/9Tx+ZUL5lIngg7JRDAI3mhG5kcAMRCMmj/PFnfmGPyRPQMkD4lBASxWsOdJ1O5/DCA
         QPXkedTQ1SgpureJ1fyC4bFkNNy7lkxmE5HSNRdHZ53YLCVaHV+S2ZW/3uFpURbTMJbR
         o6skPZ6fJzUTiOssM9VqUkJB+QvtgiVqIWl+b8GkcqeK1zMmvID8pKKiZ+fhJpOc7Q39
         jQ34flvP1XRdpzNheztZAPEm4GWE9WUI6D8FG4TvunHwtFSzjx6IsST7I6RyU+fozCPz
         7i7A==
X-Gm-Message-State: AOAM531/UxGaa/eB9NaRBaz8Dn8WBbw/vDRitIPKopUTA4GIbkCuGQ0Q
        /5Ld8byCd7Vm7LPKN5IXzFD2YQ==
X-Google-Smtp-Source: ABdhPJxMi1nfPkfOLmjDQdRZMHgZdbkFC/+JLPXFZ9DTO+fLouH+y58TOZSpuAE0JIFp8TB0TQHTug==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr3520496wrg.191.1601906737472;
        Mon, 05 Oct 2020 07:05:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z19sm12730698wmi.3.2020.10.05.07.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:05:36 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:05:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Cercueil <paul@crapouillou.net>, od@zcrc.me,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Revert "gpu/drm: ingenic: Add option to mmap GEM buffers
 cached"
Message-ID: <20201005140534.GT438822@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Cercueil <paul@crapouillou.net>, od@zcrc.me,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Christoph Hellwig <hch@lst.de>
References: <20200930165212.GA8833@lst.de>
 <20201004141758.1013317-1-paul@crapouillou.net>
 <20201004195921.GA556605@ravnborg.org>
 <ZE1PHQ.WGCBAFO9R38I3@crapouillou.net>
 <20201005230150.5637fa42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005230150.5637fa42@canb.auug.org.au>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:01:50PM +1100, Stephen Rothwell wrote:
> Hi Paul,
> 
> On Sun, 04 Oct 2020 22:11:23 +0200 Paul Cercueil <paul@crapouillou.net> wrote:
> >
> > Pushed to drm-misc-next with the changelog fix, thanks.
> > 
> > Stephen:
> > Now it should build fine again. Could you remove the BROKEN flag?
> 
> Thanks for letting me know, but the fix has not appeared in any drm
> tree included in linux-next yet ...
> 
> If it doesn't show up by the time I will merge the drm tree tomorrow, I
> will apply this revert patch myself (instead of the patch marking the
> driver BROKEN).

Yeah it should have been pushed to drm-misc-next-fixes per

https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#where-do-i-apply-my-patch

Paul, can you pls git cherry-pick -x this over to drm-misc-next-fixes?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
