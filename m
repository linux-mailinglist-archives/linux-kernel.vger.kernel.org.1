Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E013A26CC69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgIPUn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgIPRD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354EC0A888E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:48:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so2667173wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Ak62nesCbOREDTTzpc8X9wLA7URHRevPKbppowyS5I=;
        b=F+8NDuo/1RWe7wgG2WhonViKgW4VIrYKG0fuQMdu+s7s5fBfnou/S/twaeShYbWsMb
         SpuEoGcFcKnM/hRqmfdKUbO45bKl7Q1S7ixO2QN1hVzhYdN/ZC6KlkmpSJBXli3nrJC4
         C8wZha5ZkpFJr1yLUzyj/IveBKWMSQSs7Tpis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ak62nesCbOREDTTzpc8X9wLA7URHRevPKbppowyS5I=;
        b=nsFyvUH3ehJspeG5ucMhqD8BmTL2zO0bn5vPYPRCUGDyn8aNI7tW+G9gAhijc9kytV
         bMc0OsFwJbbWFysTxgDGhidHiHkt5UVkkQtzlCQYQeRGlg2W49AkQ1q+442Z+n5g/HEQ
         tMWYwOrKrXLKLfgNkh/zZiLi92jqxJj3/XTh+0/vmTDutLDmUIdlUPb+yhKLNDlohoEA
         V9cFt0GYQLSEUR1ub+SpIFH6NAK2TPV3fFavl7/WiHXU1CoINONZXiJ7R0EdtWklz1b6
         eIRI+P8loWkxzckBF0qjj85LQFQqcd5tHFMxJDrxDSD8/beixk+lFPlcU0BiyyvatyUj
         QR8w==
X-Gm-Message-State: AOAM5337P2y6EtgzGiUSXKJeyZut1HZaQm41zG1Rb/Hp3TAgRS1ORIaX
        UX5dBbDIn1sQrp2Wp7vLPlLcftEr+WAx86BSdXc8Ag==
X-Google-Smtp-Source: ABdhPJw7+Ll62XVAkpr+sbPg39fiPYa0S/X4E49SjQZq1wnxbE/A4/IKrdERM2HSi8OlQ4BlpjNN0mLfNxPL88VRoi0=
X-Received: by 2002:a1c:1902:: with SMTP id 2mr4874239wmz.26.1600260478858;
 Wed, 16 Sep 2020 05:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200916120548.364892-1-kpsingh@chromium.org> <5ab256148e8ad5f9882e888dac809bc72cd3fe66.camel@chromium.org>
In-Reply-To: <5ab256148e8ad5f9882e888dac809bc72cd3fe66.camel@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 16 Sep 2020 14:47:48 +0200
Message-ID: <CACYkzJ7dZuOL9NhzaMmpvGqE3TWYHV=AicNmjgs1aD81TctR0Q@mail.gmail.com>
Subject: Re: [PATCH] ima: Fix NULL pointer dereference in ima_file_hash
To:     Florent Revest <revest@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow this patch does not seem to have been picked up by any of the
mailing list archives and I am not sure if this was delivered to the
lists. I will send a v2 and add Florent's Reviewed-by tag.

On Wed, Sep 16, 2020 at 2:41 PM Florent Revest <revest@chromium.org> wrote:
>
> Reviewed-by: Florent Revest <revest@chromium.org>
>
> On Wed, 2020-09-16 at 12:05 +0000, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > ima_file_hash can be called when there is no iint->ima_hash available
> > even though the inode exists in the integrity cache.
> >
> > An example where this can happen (suggested by Jann Horn):
> >
> > Process A does:
> >
> >       while(1) {
> >               unlink("/tmp/imafoo");
> >               fd = open("/tmp/imafoo", O_RDWR|O_CREAT|O_TRUNC, 0700);
> >               if (fd == -1) {
> >                       perror("open");
> >                       continue;
> >               }
> >               write(fd, "A", 1);
> >               close(fd);
> >       }
> >
> > and Process B does:
> >
> >       while (1) {
> >               int fd = open("/tmp/imafoo", O_RDONLY);
> >               if (fd == -1)
> >                       continue;
> >               char *mapping = mmap(NULL, 0x1000, PROT_READ|PROT_EXEC,
> >                                    MAP_PRIVATE, fd, 0);
> >               if (mapping != MAP_FAILED)
> >                       munmap(mapping, 0x1000);
> >               close(fd);
> >       }
> >
> > Due to the race to get the iint->mutex between ima_file_hash and
> > process_measurement iint->ima_hash could still be NULL.
> >
> > Fixes: 6beea7afcc72 ("ima: add the ability to query the cached hash
> > of a given file")
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  security/integrity/ima/ima_main.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index 8a91711ca79b..4c86cd4eece0 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf,
> > size_t buf_size)
> >               return -EOPNOTSUPP;
> >
> >       mutex_lock(&iint->mutex);
> > +
> > +     /*
> > +      * ima_file_hash can be called when ima_collect_measurement has
> > still
> > +      * not been called, we might not always have a hash.
> > +      */
> > +     if (!iint->ima_hash) {
> > +             mutex_unlock(&iint->mutex);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       if (buf) {
> >               size_t copied_size;
> >
>
