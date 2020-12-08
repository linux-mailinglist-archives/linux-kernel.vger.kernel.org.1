Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE72D352B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgLHVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgLHVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:24:39 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A69C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:23:58 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id y22so7245180ljn.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtI8aWS2XBU6E+db2R347MjtIB/R2TuW+JI08/V//xI=;
        b=IX2+1eiVYs54WNPTx865dRN+VfZEy8FmzNHCJlr0nkTBrazPeMBbK0B6P6Bc0Ervo7
         lIQc7C4G9hlb8+jo8nZ+kr4AsXv0jKoBgIWW3f6NhLMOMd9YdtBoiG/YKxnS/zUjisqP
         OoeDeTYj7iX17QGH19mdD+qa/PRj0zIINeozQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtI8aWS2XBU6E+db2R347MjtIB/R2TuW+JI08/V//xI=;
        b=mTAws4IMW8crbcSO/Y10rXg+I9stu5bli6xRdnsekeZb+oPr00MHkO+uh3OHgrI58q
         eRekrksKHfTi5FKBwPrkG7VzUMwm0slAExLkHzW5ZBWJm8o3UeM+fpUyFVHHDqWan3Xn
         eHECTl2G4bIsoAzl9r1zlYtkNdg0pnWlxfffRTiXpv+tSXdP5q/8yebQodp1Zzi6FYZd
         pCWSSC/N7huwlljTb+LZl9msp7yS29G/LmKUsom6oYxhO4y55aC1nTkrAJGgrt3QNBEK
         O1ppd0aJldYud7BTOzKYhBdD/3h//hiH+BqY6ruvlviJg3ySK4tBdztMp1xRy9shQUQl
         Sx9g==
X-Gm-Message-State: AOAM531ajWV/4SSMGWqv/gvXyTCUMxZGeo4ymt5G+ZSnNq/AHJMIBzXe
        CbvYWN7L24lFpjGwOs4W254YsnD3POi8Vg==
X-Google-Smtp-Source: ABdhPJyO0fu7YpQQYbKuciaGid5IG2rVDt8mN5iY/YUsRkGSy7zfo2wIHFGE5pN5G996LniZT6xIhg==
X-Received: by 2002:a2e:98d9:: with SMTP id s25mr1160420ljj.476.1607462635838;
        Tue, 08 Dec 2020 13:23:55 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m20sm3521530ljo.42.2020.12.08.13.23.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 13:23:53 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id e7so11859518ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:23:53 -0800 (PST)
X-Received: by 2002:a2e:90cb:: with SMTP id o11mr11822819ljg.465.1607462632951;
 Tue, 08 Dec 2020 13:23:52 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
 <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
 <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com> <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
 <9106e994-bb4b-4148-1280-f08f71427420@huawei.com>
In-Reply-To: <9106e994-bb4b-4148-1280-f08f71427420@huawei.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 13:23:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsWB612YA0OSpVPkzePxQWyqcSGDaY1-x3R2AgjOCqSQ@mail.gmail.com>
Message-ID: <CAHk-=wjsWB612YA0OSpVPkzePxQWyqcSGDaY1-x3R2AgjOCqSQ@mail.gmail.com>
Subject: Re: problem booting 5.10
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.palix@univ-grenoble-alpes.fr,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 1:14 PM John Garry <john.garry@huawei.com> wrote:
>
> JFYI, About "scsi: megaraid_sas: Added support for shared host tagset
> for cpuhotplug", we did have an issue reported here already from Qian
> about a boot hang:

Hmm. That does sound like it might be it.

At this point, the patches from Ming Lei seem to be a riskier approach
than perhaps just reverting the megaraid_sas change?

It looks like those patches are queued up for 5.11, and we could
re-apply the megaraid_sas change then?

Jens, comments?

And Julia - if it's that thing, then a

    git revert 103fbf8e4020

would be the thing to test.

           Linus
