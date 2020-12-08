Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C472D33D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgLHU1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgLHU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:27:06 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F82C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:26:20 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id j10so21808380lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4rfdB1itUPJzwPX2Po0DzKsfVLu6c50Jbl8+ApJIs4=;
        b=gjXtM9gA8YK4ZCg8BJC8Pa3iGb+RtJZzHwFcdtxxrHUSznzdQ+ZeGIlHNbYSebjGpR
         yK+Ynkl9e7k+Ve5Mjo6kCGM788cdVq2NSwCT1g42MEc+y2m/yO29Ks2lx5+abA9p6CCz
         jJkRy/aRTHlkcix67CQ4mfT7m2WY5vsI4/rAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4rfdB1itUPJzwPX2Po0DzKsfVLu6c50Jbl8+ApJIs4=;
        b=qzSpmdzvKAMlVTG6pgIprasH2lLNGXSje+/OPI2C0I1q0B778eYf49o8+y7AP+nUwG
         8r415fyQCkEVU93KjAsQqH95chYvD9CXsmgTKCOYE8mbjD9MNsTPyuP0ulLTlCLZF4xc
         m8W+Kudf8CdBc0ACSQbt3Afy6O7ixsTR7Mjnj/nHY3twYfpTIDhKznR9oEA3rDG2MNEL
         yta/cj3wz/n9e3KZEChlGz4Q1sqyenIIQpxqGoEW93lMYONARSdgMfyDgeNqYvn8TRs/
         CzGBL6QxWpu9sW3x8vX9njfpRy+buiPuUHjv8D903t2IUYZOqv4Bu7XJgXY4PL8tg9Bm
         yQAQ==
X-Gm-Message-State: AOAM531qjVVjmu3py/e+fFYaFEqXMY0zbKyFaYbW0YAK8Mdu9ffLKbmo
        rbEpw03Ra8pJyiME4Ye5XkdggjPJFE42qQ==
X-Google-Smtp-Source: ABdhPJz+jTOzeKWcorseht0PlkQ9pyUgXuLkc7DUCjWeyt3GP9J9ijW1irHsijbhDihSUKyXqEsBaw==
X-Received: by 2002:a2e:9c82:: with SMTP id x2mr5169074lji.190.1607459178662;
        Tue, 08 Dec 2020 12:26:18 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b22sm791340lfp.233.2020.12.08.12.26.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 12:26:18 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id a1so20491860ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:26:16 -0800 (PST)
X-Received: by 2002:a2e:5750:: with SMTP id r16mr11173514ljd.61.1607459175646;
 Tue, 08 Dec 2020 12:26:15 -0800 (PST)
MIME-Version: 1.0
References: <20201115155355.GR3576660@ZenIV.linux.org.uk> <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de>
 <20201208163552.GA15052@lst.de> <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
 <20201208194935.GH3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201208194935.GH3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 12:25:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
Message-ID: <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 11:49 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Said that, it does appear to survive all beating, and it does fix
> a regression introduced in this cycle, so, provided that amount of
> comments in there is OK with you...

Ok, considering Greg's note, I've pulled it. It's early in the last
week, if something comes up we can still fix it.

That said, considering that I think the only use-case was that odd
/proc splice use, and the really special WSL2 thing, and both of those
are verified, it does sound safe to pull.

Famous last words...

Al, since you're around, would you mind looking at the two
DCACHE_DONTCACHE patches too? Honestly, since they seem to be an issue
only for DAX, and only for DAX policy changes, I don't consider them
critical for 5.10, but they've been around for a while now.

         Linus
