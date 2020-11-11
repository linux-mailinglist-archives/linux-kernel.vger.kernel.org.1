Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1D2AFCEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgKLBcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgKKWqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:46:45 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183DCC0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:27:22 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id h23so3833640ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLOabNKoNSfJ8YlJALUX/HSF7x5smlTVZLW77pgDXxE=;
        b=IRSGHIcCR371rgKVLVF0IWNeekp7RPE0tq0jXgz/fCbjpYkabNrYN8yq8L6uP1wNLm
         iQV9DdRexGpEEOJh3X5FNLU9tmqj7DBi9Jq9H9z+BIkxguhTupVA5zY3gmTZBfYvUSdr
         RBkqVcAV8M5WnEewVOMQWCUC58Swu7KJUcmrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLOabNKoNSfJ8YlJALUX/HSF7x5smlTVZLW77pgDXxE=;
        b=BI9UfB6TkepvKbqySm+0HkqCXapBWoYztTHoYnHJPh2DzsFPB3b02scfjgXBytG5QA
         kgn3LxahzOE6u+Hv6aloN2zSEQ9VnTpuCZSDhXiOqiyQc7v+kmXhlFZZc5zjdiNcxtIm
         n/mddarvd4q4UgzTcOFl3kRq/ltm2/+IH+ni0RmiJScCIUO0XgOxJezEYnrjevOaPyR0
         EfoEuSsJ74xTUuMm1MJKUIDKVe3eG6Ab9HQO31T/JRKLM+HFpiP0cmH78Ah8kGsypnDy
         OVKKpmVTNxKXe2uQAVUyPQgMCyTGBpf9zSXoUU5tvkRYVxF9NUkJqlmn7alJ6TRe2Dl6
         igDg==
X-Gm-Message-State: AOAM5325o2EENaQVZaWXXBs4mRqJzhEY/7vxT2Jf4CNy1WY2iXe0PGBm
        TJIiqi4H4bmfC8DEJRi8pW2FLKkxYJzhFg==
X-Google-Smtp-Source: ABdhPJxVRCvEugz1Vxcjw2TXgbk/SCcHSu7uDL4WGKy77UxKbavhrG+vJSmoUCTNgk88c6/jcx0TYA==
X-Received: by 2002:a2e:9a43:: with SMTP id k3mr11916144ljj.69.1605133640112;
        Wed, 11 Nov 2020 14:27:20 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r3sm347969lfc.85.2020.11.11.14.27.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 14:27:19 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id x9so3853865ljc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:27:18 -0800 (PST)
X-Received: by 2002:a05:651c:110:: with SMTP id a16mr12194059ljb.285.1605133638694;
 Wed, 11 Nov 2020 14:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20201104082738.1054792-1-hch@lst.de> <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk> <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk> <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk> <20201111222116.GA919131@ZenIV.linux.org.uk>
In-Reply-To: <20201111222116.GA919131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Nov 2020 14:27:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRM_wDsz1AZ4hyWbctikjSXsYMe-ofvtnQRQ1mFcTqnA@mail.gmail.com>
Message-ID: <CAHk-=wiRM_wDsz1AZ4hyWbctikjSXsYMe-ofvtnQRQ1mFcTqnA@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 2:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Something like below (build-tested only):

Apart from my usual "oh, Gods, the iter model really does confuse me"
this looks more like what I expected, yes.

Considering the original bug, I'm clearly not the only one confused by
the iov_iter helper functions and the rules..

             Linus
