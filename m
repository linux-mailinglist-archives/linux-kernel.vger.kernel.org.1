Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1397A241DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgHKQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbgHKQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:09:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C47C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:09:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v12so14125208ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARDqa0ttwGGpwIjIpukccBn4z80sUg1Y95J7pw/cBrc=;
        b=ARjGfgTTe8Hs0S97+HBco6KPkmP42m5OKE0ERo6Sf2t684ErIUsYZb+F9N6GI8m7VH
         sHrR/7XxUU0WvzcWkmBHB9j/WQDrOrGh9T97uhNn/7Dj2ZTIxVy3Iz23WUYyWjs31hnR
         EPcWsf2mQ8nUFDg+i2/4NJ7eEH6TQJE7uk7EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARDqa0ttwGGpwIjIpukccBn4z80sUg1Y95J7pw/cBrc=;
        b=LlUVH+MtPrjRJQ6zyytch/V9J5pEt9mlU1ldPO7DfjCEMZIcwbuAO/JHxS+MSVUGdq
         woHP1eZzp3+qRiHciW8U5Vmnutw+F8Hr/Uexi4zFrryZMfzmBN4O4vgXDqcOwpd1uiNj
         A9LHKWymHaEHPb7liNkPQiLJYGK0ljBEc6QfUosFumBL+/wTGAKoIERYTeq1Qex8ziX/
         Ohs7ZqlWiNLVggYxZOw8CZDXEe0RypDVsHoBaQnhXJz1sl63ZR5KF+fbbzTVdwftNcAG
         100diSthExila/+yB2pNb0RiF244kBAvt+mh1e8q3fbv7ekHVu1qkqUFhBmTdIZgOvfw
         y1Ew==
X-Gm-Message-State: AOAM530EavdIMTL2Kh41Wa7sOxu5vrpOntqWFE+GF+HzwWiu8QtVNwKO
        wgt+GwJ/l6N/gbF6s3kvgGrFhYROzuI=
X-Google-Smtp-Source: ABdhPJyZluq8Rnan9hlxBHcLb1+75bvxKDLCHAubXW79alBfkceJPs0NdnSzby/32q+bS0k7Fjp58w==
X-Received: by 2002:a2e:8717:: with SMTP id m23mr3488352lji.245.1597162194287;
        Tue, 11 Aug 2020 09:09:54 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h5sm11698239lfm.70.2020.08.11.09.09.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:09:53 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id z14so14175121ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:09:53 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr3191279ljc.371.1597162192777;
 Tue, 11 Aug 2020 09:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <20200811160534.GL1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811160534.GL1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:09:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHZig-+dXQeW4pPEjdYsrq=3bgc+vUhwiT2Ox4ipLHwg@mail.gmail.com>
Message-ID: <CAHk-=wgHZig-+dXQeW4pPEjdYsrq=3bgc+vUhwiT2Ox4ipLHwg@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 9:05 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Except that you suddenly see non-directory dentries get children.
> And a lot of dcache-related logics needs to be changed if that
> becomes possible.

Yeah, I think you'd basically need to associate a (dynamic)
mount-point to that path when you start doing O_ALT. Or something.

And it might not be reasonably implementable. I just think that as
_interface_ it's unambiguous and fairly clean, and if Miklos can
implement something like that, I think it would be maintainable.

No?

                Linus
