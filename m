Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8726F4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIRDcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIRDcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:32:23 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A298C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:32:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r9so5334554ioa.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPfn4rdBew7aKFWhRQjD3cboCteJKrBsGnCZeS8Y5jY=;
        b=cmywM6Jb7lPoDpe6aana4LL4RyOMq8hdEPqtllD8pAM6388lg0hTs6WS3jq09PKFpg
         /lXsYf3jDOSs1CsDoaSOOOFw/GZOibUdXA5JNiLV/4HKV4V/LltrshVX0i9T3p5Obu5A
         iIGyV7K3p+FtvZAJBTxqNWjhnHygt7+rhBvbVx/1ygmpdgbTIxNNClCEQ7HxoaIF91uf
         sUAx2V5q4Um2krAgBz30D1ohEowQGYJG4Q/o1jdWCpsMd8XKatmzKiT989C/a4WQU9UR
         0v8hZ5vt2qgioSls7Nk0ZmcpsbXc3ToIt7+n7kTI3xRhVu5l6GtE2Y58ilFWMVna78aL
         qJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPfn4rdBew7aKFWhRQjD3cboCteJKrBsGnCZeS8Y5jY=;
        b=cvG1/eUlpwaqY4+2mApyzN+lQ7fkj1CTW1zyf9fAOAH7JokUG3fT/gKeAjwIE2Dt+H
         FDDkNSefi790GqLThhK3ggeTmUujYzHL7xph9AWtdWnHjY3UFdHBvtFTWxlnAhQnJNJl
         8m7noBsv1XKjrbiUNhk1e13p0A7xFWDuKLYjJS3w2itpEZ+zhh+0IaYtaspSGFTbISkX
         4P34ucOpzmbhK3B1iZoH3ZklFZQolO96UWrcpNakOpvwq2o4OO0zDufYBnh+RARQ0WWL
         697D6r/JJbqK0afzgQrDBzeGxS/IyaAl1hWAzHCTK02k4SVRo8qtHy5sjCeg5Dn9hDl9
         iEGg==
X-Gm-Message-State: AOAM531L45fo3+znHfPRvsiYTGJx7ehNacWAnJEnUHWt1PcIDfHgQ1Ob
        k9ajM0CvkdSkfJtWhdP46WZ3l470+LAs5222iSA=
X-Google-Smtp-Source: ABdhPJyxwieaP7FDRYrpmgKiq5RdWWk10z+MLIfwDM6zwC/YS/veccRpviZw8Z8jGyKSsBfC9tEy52kKKdpzZq/OmL0=
X-Received: by 2002:a02:a615:: with SMTP id c21mr28913596jam.106.1600399942791;
 Thu, 17 Sep 2020 20:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153648.5475-1-ztong0001@gmail.com> <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
 <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com> <CAA5qM4Bj3BqYt-J=YqWKMWLFxDaMwQa4qAqPibyikpX5FBSzRQ@mail.gmail.com>
In-Reply-To: <CAA5qM4Bj3BqYt-J=YqWKMWLFxDaMwQa4qAqPibyikpX5FBSzRQ@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 17 Sep 2020 23:32:12 -0400
Message-ID: <CAA5qM4ADbaO25t7GzC7jqB_jamHgegUyuNMvpo5h1+h=rir2mA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please correct me if I am wrong.
After a bit more digging I found out that it is indeed command_id got
corrupted is causing this problem. Although the tag and command_id
range is checked like you said, the elements in rqs cannot be
guaranteed to be not NULL. thus although the range check is passed,
blk_mq_tag_to_rq() can still return NULL. It is clear that the current
sanitization is not enough and there's more implication about this --
when all rqs got populated, a corrupted command_id may silently
corrupt other data not belonging to the current command.

- Tong

On Thu, Sep 17, 2020 at 8:44 PM Tong Zhang <ztong0001@gmail.com> wrote:
>
> Hmm..Yeah.. I see your point.
> I was naivly thinking the command_id was the culprit.
>
> On Thu, Sep 17, 2020 at 1:14 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Thu, Sep 17, 2020 at 12:56:59PM -0400, Tong Zhang wrote:
> > > The command_id in CQE is writable by NVMe controller, driver should
> > > check its sanity before using it.
> >
> > We already do that.
