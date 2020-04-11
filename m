Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1F1A53E6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 00:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgDKWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 18:09:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37576 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDKWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:09:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so5295470ljd.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TETsvPIW3zFK7a+s4Xy+/EsP/ZIyd7MDAnh8kXDUPDY=;
        b=LWKhzNO/fmkN9AXIbh6BdMPSoUwuuc1JIQbspBQF8oSJHNi+9xPH2NDbM8dVz5Mzia
         O5Bv8VqXhUpaAfmywLN4z2mbstp/udAPbBebWk/RVBwyz93e9k0XSh0EtntzOz886wT6
         HCLCmJBbcNFSByCMNpooPlQvhUTqF3YMn4tsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TETsvPIW3zFK7a+s4Xy+/EsP/ZIyd7MDAnh8kXDUPDY=;
        b=qf85gICiRtQoBrJZR1YRV5yAft3abNNSBdKx1dRBCyS+snKUhmMO9ZnDjSNhmkDBOg
         7r2j9xOQFV2nCWrfSqsF0VgeO2kKjsitjFVjij0r0Pg7PfXqyYL6AhtaqFTG7jymKsBx
         TpZDD/OS0m90BbW7Y9mWS/0K7ROwBr8E+8cxZvujPuw6duuXTG7FojlW3JgRTXuRNDRr
         NZz8KaWyKhYL1fGUM7Vb4G0gm4d72Z2V+048BwlK/n6BqaP45IzURUy6ZSHePA3oSQXg
         2OJWqspubWRfYW7RKFjRWxogB4RmiF4m49a96Fhu1auyUJmdIm3cov+LAMUQmHtBMb1F
         fUgg==
X-Gm-Message-State: AGi0Pub6oWpsReFdakpDGqQkjbg7vveJJBt0D8x+8TFlEs5PpjqRTtrO
        0sVUdqt8VYzrQ0pemJtlSYihdcQCiKU=
X-Google-Smtp-Source: APiQypKSRKiQ+znK1mHeTaAzDM6g/tU467khK21no9Y0g9UkDoOHA7wWvGH/jVTSk+I/zu0UeZa13g==
X-Received: by 2002:a2e:80d7:: with SMTP id r23mr3312314ljg.148.1586642992947;
        Sat, 11 Apr 2020 15:09:52 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w16sm4708017lfk.49.2020.04.11.15.09.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 15:09:52 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id w145so3834636lff.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:09:51 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr6353420lfd.10.1586642991463;
 Sat, 11 Apr 2020 15:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200411203220.GG21484@bombadil.infradead.org>
 <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
 <20200411214818.GH21484@bombadil.infradead.org> <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
 <20200411220603.GI21484@bombadil.infradead.org>
In-Reply-To: <20200411220603.GI21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 15:09:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFfcUEMq5C9Xy=c=sJrT-+3uOE2bAwEQo9MUdbhP2X3Q@mail.gmail.com>
Message-ID: <CAHk-=whFfcUEMq5C9Xy=c=sJrT-+3uOE2bAwEQo9MUdbhP2X3Q@mail.gmail.com>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 3:06 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> But we _have_ an offset_in_page() and it doesn't take a struct page
> argument.

.. it doesn't take a struct page argument because a struct page always
has one compile-time fixed size.

The only reason you seem to want to get the new interface is because
you want to change that fact.

So yes, you'd have to change the _existing_ offset_in_page() to take
that extra "which page" argument.

That's not confusing.

             Linus
