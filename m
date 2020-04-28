Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362A01BC62F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 19:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgD1RHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgD1RHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:07:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BE3C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:07:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h4so8725097ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qndSSY39gjmwARBk0gMZpVxJGZXAdDCTZw9QYK8z9Zc=;
        b=K+RzLPalq2YYOUqS4dRehI3hWyV9pRDYFPkf3L3pugPSaBhI5tGJkgZMAGNOjZj3S9
         FDYVRNA83t8OPlXj8nWhnPp6lWZp70q5PBtj50bLcrIXhtsqZC8Jg5Q8iTaP60LnXJQe
         OguBrTIAsNFF4ezd6qplm3mFAj26zIrAmEKgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qndSSY39gjmwARBk0gMZpVxJGZXAdDCTZw9QYK8z9Zc=;
        b=kPI/B+KoKEmteJN2t8+2URY2hrAETFcdeLlhgA2Ho3ZYV73roP1ZxgNowDHJhNsu6G
         vbPt8W7QWN4oseHemIg+oVd9PoDe1fvF69mXCnkzICCgKzpM8Tm1KgfNjLSd+uMWJgJV
         6LQ1DiHcczR7rJecs4Hxo+cRzCX74rMTmOXyZe3GiLufpy9k3Ho1v7Xl7wwve5nVhxj1
         q2X2+H7g/i05Yej1+oUavQRyoApmh3NNnCnHFYbT+Aak5iQ3pLeRN3QDWyUO9NF5FOA7
         Y1Qon3cm6Jp4cAaKbvfXy4ds3jUmYlhizCQc1Yjd4DnY0dUfDcGS0lc7rKQxERt8YzEJ
         Iofg==
X-Gm-Message-State: AGi0PubcgUc0BESBLlCmSgz1gBuk1ApCX2exn6XsPGXW0UcIO3ImFTx4
        kWgNA2CjQ2AGU3bRO46laXEVNF9uSW0=
X-Google-Smtp-Source: APiQypIRT99D4wdrPx7xmAR2L5OB6QppHJg3emkSfsR0CJo7PaTgzpmdS1v/FuI4CMzh1LzYdaF1xQ==
X-Received: by 2002:a2e:9596:: with SMTP id w22mr19110126ljh.9.1588093653926;
        Tue, 28 Apr 2020 10:07:33 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 137sm15016462lfa.48.2020.04.28.10.07.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 10:07:32 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id b2so22233613ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:07:32 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr16990262ljp.209.1588093651890;
 Tue, 28 Apr 2020 10:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 10:07:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
Message-ID: <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 7:56 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> was this resolved meanwhile?

No. I think the tentative plan is to just apply Oleg's "don't wait for
zombie threads with cred_guard_mutex held" patch, hopefully with that
de_thread() moved into install_exec_creds() (right after the dropping
of the locks).

But since it's arguably a user-level bug, and not a regression by any
means, it's not been exactly urgent. I suspect I'd like Oleg to
perhaps decide to take the patch up again.

              Linus
