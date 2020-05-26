Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977EE1AD3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 02:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgDQAxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 20:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728454AbgDQAxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:53:07 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF240C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:53:05 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id t8so92093uap.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jgottula-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXpaYcM38eFB67KwCt1Jc+C3DFRaou4chRNhAdr9Drk=;
        b=TzohkwjGPu93u+uoaV1E/xBsqITd23SUw2sElHtGpNG3AIau0zjMyxDcJ8oAwIYWCU
         BtqS/oikJfPV8Yj8A+WI+zPJeygqHyTf2+6hF0gR/E7sPiJdXSO3rYm102WFfiQxfahy
         ZycsZkbCTwkSf/AkanunUMi83CynOLyrQ25vThm7Tdtz3wmr7P8Ddnvs7aU188kV4KZs
         gt9smKRa0bNqw8bVfycQHBD+JlQlvT/mETDCug1Rq2aykKxOpSPvWIFl9w3YP1Hn7UA8
         chi3yjVqQnPx0jZAMKIfv1Tl7y+hUNqVUMSxE8o3WA7w845hdO7IPKrMmHKoTF0ZBMvZ
         3oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXpaYcM38eFB67KwCt1Jc+C3DFRaou4chRNhAdr9Drk=;
        b=L52W+xPjo6Q8JFgyD69Z7Atncuf9rkQTo3Yz7sKlyWQ642o4QRBH19wO9VNAMQ6RE+
         i/pZmuc9kFEQFq9L556UBBfEQCJLbWPT2wUxCn8Q8yItG4poK8i0HV1z86P32QuKU87w
         X2fYze0w6jVF/e7W6jdIx6LDzoRoZKsUhLyKgZJDOV6gdZDLki6EqJ3Ox5RdmAsSV0JT
         rywuQPuvGbP3U9JViUsGPmj+WTssHCNx8XK3+sFBZ1c8fADUeqh4Av462WGuEhD7HTLe
         Zn6+XZurQzGcGsPljZIfK/fQVavrpFr2/RXnkgerl5c8G+6hbhQyrZl77hxN5nbP7u8U
         AHnA==
X-Gm-Message-State: AGi0PubmB5n4nON07ynTYK3eoOfkjGRIdVe/BIs2GjBzs0/D5p4wuDkG
        b4939As0stJMBckaGCgrXDZEZfxaBIyZLr9lFCcmOg==
X-Google-Smtp-Source: APiQypIjQeD0xbl0pQkYtPwJq9AE4eIXIMTcKwyOgHP/M2El9rtHAOyIzpwWPtBZinQy+KY8nlq4hF1xffnIsgkQwRA=
X-Received: by 2002:ab0:29da:: with SMTP id i26mr558953uaq.29.1587084785007;
 Thu, 16 Apr 2020 17:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKuMfTUPzPjuNk+T_GQMCKoB9ssh2arr6xRiu6VODwwB0PMdZw@mail.gmail.com>
 <20200416214649.GA60148@google.com> <CAKuMfTVpaetB0qQ_hm8cSowtZN8HUKXdADWhKXC=4eKd1i5oSw@mail.gmail.com>
In-Reply-To: <CAKuMfTVpaetB0qQ_hm8cSowtZN8HUKXdADWhKXC=4eKd1i5oSw@mail.gmail.com>
From:   Justin Gottula <justin@jgottula.com>
Date:   Thu, 16 Apr 2020 17:52:31 -0700
Message-ID: <CAKuMfTX3PW8FgpGyp1g=CZm4yC6pQ_MK4LFmBoin2zCTqDF0xQ@mail.gmail.com>
Subject: Re: [PATCH] zram: fix writeback_store returning zero in most situations
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 5:45 PM Justin Gottula <justin@jgottula.com> wrote:
>
> 2. There is a bit of a predicament with the keep-going-even-if-an-error-
> happened approach. [...]

Oops. I meant to also include this in my reply:

I suppose a reasonable way to address #2 might be to condense any error(s)
arising from submit_bio_wait into one writeback_store error return value
whose purpose is to indicate that the backing device itself had some sort
of write problem(s).
