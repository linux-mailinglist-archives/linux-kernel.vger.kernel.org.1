Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8521D201B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 22:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390853AbgEMUSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732650AbgEMUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:18:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3334AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:18:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j13so1470102pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFhpUl8J5nQNcbuIqqWOyLKJFuf8vP/sTwp9lphBqIg=;
        b=OVOopRhHDJPSVt582OWv1n2bHvL2RJ4Ej1usaI3YQLjZfCdK5RRj5bkjRcOW0/tyr8
         SkhLd0zgDwlz64rxPOTE7BwwGl5aeGThK9Y+BL9roibAfYro/ahbloBkaGKJeHgWaIMT
         tHuqGbOt+suQHKd76FwG9a4krZjPc92s2L+l4AiS8MgX6FUiLAzWasqjYUCzdyE8VKHx
         4q7pIWkp7OS7sNMDmT0EuL7LNc8eEVX69ujKM1vOTQQWSsfgRFQQ1DfzbUwPBblRxQhw
         CuB9fl6jZXfzLQ/q/9xkkJnVNnEhXJqZRMrScETEkHIBjDtkSIUcufuRJ6oo86NlekIZ
         Jfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFhpUl8J5nQNcbuIqqWOyLKJFuf8vP/sTwp9lphBqIg=;
        b=nXtSJyj2O1eGEr9mlTTah4NrdpuscYqUkCbNR8tukGXJK0y2yuSR1F5228umIzNJVc
         ZMyIX68EkuquNbw7ddSgHcZpo64f7AfcNphXpRYkZnJW3nBfLzdfLAkC2kgdmtfn9ypM
         vz+4JXm3xb+RfhvoRYKeIPi29J3q49itqvyPH+Vl7uUy/UE9K5jxYjSYEMb9YF5MMQq5
         kEWc8Iu1cMOgIRkwIjDj7WQ0zH99uoLvnQ5Q3rRJ4+H9tTiEB8Ss7fjIyxWP90rYXR1Y
         qJGbkOcR1WPVuHelscAbNX3gkX7HV+5HqXSvYoKoJFEB2B57zc4pAr8k+Y4nvvS+0tNQ
         8y1A==
X-Gm-Message-State: AGi0Pub8SMZr24Po5+/NuOMzzHn6sw82rhIQEKXWJmB3eZ6aj7yXI4Vn
        YCX7tkigY8Ir1bo2ahy54HXbTv3+bj4JP+l7pxzZ7A==
X-Google-Smtp-Source: APiQypL5qdvL27yQKnl1AbUHtAzXV73gwoxo3Zlu4/03cZATWKqFrDYk4v09riH3sBZr3ki1nShdVY7CkbDGaHWUlD0=
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr33102641pja.80.1589401129515;
 Wed, 13 May 2020 13:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 13 May 2020 13:18:38 -0700
Message-ID: <CAFd5g46npUaVOu9+xvLqw=DhCccuzOLpFLn1+8Qc8Un0AALThg@mail.gmail.com>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 8:18 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> In the function kobject_cleanup(), kobject_del(kobj) is
> called before the kobj->release(). That makes it possible to
> release the parent of the kobject before the kobject itself.
>
> To fix that, adding function __kboject_del() that does
> everything that kobject_del() does except release the parent
> reference. kobject_cleanup() then calls __kobject_del()
> instead of kobject_del(), and separately decrements the
> reference count of the parent kobject after kobj->release()
> has been called.

I was starting to wonder if anything else needed to happen with this. :-)

Thanks for taking care of this!

> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Didn't I and someone else test this?

Either way, I will test this out in a little bit.

Thanks!
