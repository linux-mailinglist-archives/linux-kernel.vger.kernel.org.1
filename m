Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B21E1A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 07:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgEZFOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 01:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgEZFOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 01:14:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C111C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 22:14:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so11526811lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 22:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuaiA4ng6JUJ2rRiSTrDIHbauCFmhUkJTDFY3YPq0vU=;
        b=Hk06l/ol1I/EnHo1jbjmEwYWeIjuQizHeH0L3/yQiOWSaFKDRfbuTs7CxMCh/nt72O
         uIdT4ZeBBs4EQPcwv1s5iLEt6gJ9YaZxac31fWfDPFaZOaewmmhQRV1zECBwaA10fP11
         LW+AvyTjUS0F+HDT91ORxiKBtRMbdEZpK0QElZN4sR5TNgHWDNLbQGpxjDgYPoCkFO2D
         RJer1zF7IVw7Y4iZoMoCchg3rNqYCuFpCzcVQYlamAldpDUy7F0GgfQpiGpdQW8TtX4T
         PgeVornAko8KK3HvK8/0yy8NsTvpPWXlDwx+0KpXwW9SvYL/93MQKyc5WcWA51/ULE5/
         BzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuaiA4ng6JUJ2rRiSTrDIHbauCFmhUkJTDFY3YPq0vU=;
        b=oYBnvsQH8CHCXTSfNCvs4N6RWb+a4F2nV99TF+tq53zOPBkhfhzjur7Q24Jy8UzRcc
         jCRwKNRbdPP/9RMqWltpKzH1tZsgGg42xzhPCfjcqQHzeq6PMPDwut5T4gnobWTKbxaD
         ik0tOPqY9lcnXzSdxDhC6w0Q+X/OdGthjGKaUMOC8bjYkrMeV3yqCPXItAa+mp3gkGyr
         /OGmJEPFxSzb/Ae3lTaExnJi5M0Iz0CdO19Z4ywIRD4yOOCNeReYOHgnyGm9M9oDCkWq
         DpvH12tbeD+nPfj9XRrI1rwO19R1zuSDdxLVTyUc0+BTPdmu2G+0H2njJVKhSStD62Lx
         rwPA==
X-Gm-Message-State: AOAM533IzikH53FneSbMGkiSRyJFmfMHmS+aoxfbBux4PxyhhI0jVcHs
        T8jAz+FRu0Q+uittIcamP+a99LAAXwoqvCsDBBA=
X-Google-Smtp-Source: ABdhPJzykETPKwdqiXtEX6ryxAIkkSp/Zws+3iH9+YEMHTqr9Pnvhqs2Mmz1WVovwmbqW1TC7N0y8EtX0YRI33SUla8=
X-Received: by 2002:a19:500e:: with SMTP id e14mr15950129lfb.88.1590470043532;
 Mon, 25 May 2020 22:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <1589401396-31210-1-git-send-email-jrdr.linux@gmail.com> <20200522125349.GF22511@kadam>
In-Reply-To: <20200522125349.GF22511@kadam>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 26 May 2020 10:43:52 +0530
Message-ID: <CAFqt6za+svDtyJ7ADzWKvy1M4u-ky39Q-yWqXXcOLwo6D6XEug@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt/fsl_hypervisor: Correcting error handling path
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, dsterba@suse.com,
        Arnd Bergmann <arnd@arndb.de>, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 6:24 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, May 14, 2020 at 01:53:16AM +0530, Souptick Joarder wrote:
> > First, when memory allocation for sg_list_unaligned failed, there
> > is no point of calling put_pages() as we haven't pinned any pages.
> >
> > Second, if get_user_pages_fast() failed we should unpinned num_pinned
> > pages, no point of checking till num_pages.
> >
> > This will address both.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> If gup_flags were | FOLL_LONGTERM then this patch would fix a double
> free because of the put_page() in __gup_longterm_locked().
>
> mm/gup.c
>   1786                  if (check_dax_vmas(vmas_tmp, rc)) {
>   1787                          for (i = 0; i < rc; i++)
>   1788                                  put_page(pages[i]);
>                                         ^^^^^^^^^^^^^^^^^^^
> put_page() here and also in the caller.
>
>   1789                          rc = -EOPNOTSUPP;
>   1790                          goto out;
>   1791                  }
>
> But since this isn't FOLL_LONGTERM the patch is a nice cleanup which
> doesn't affect run time.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Hi Andrew,
Is it fine to take it through mm tree ?
