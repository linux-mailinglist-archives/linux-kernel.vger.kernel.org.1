Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B8C26FB03
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIRK5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:57:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35010 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRK5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:57:10 -0400
X-Greylist: delayed 1037 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 06:57:08 EDT
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kJDnx-00071Q-DZ
        for linux-kernel@vger.kernel.org; Fri, 18 Sep 2020 10:39:49 +0000
Received: by mail-lf1-f69.google.com with SMTP id 23so930542lfy.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TQIpEkK3UURZSuTWdFxaxjlA5aeVAZ+3spWA7nEMrY=;
        b=qJXKpkfyx6C/o+4enVrZ0szHg+BmNuQw/ZZ0UN/LwSNkYmVBne7Su745oUmpC/okYb
         xh0/WJB209rIratxSE9+ZyJheQ3SHnsQqnHfmpMqjZEpUWziOFTdsJMv+wu8O1h6LryK
         +7Dg8fsGTuCUeqRg48Cvt9VX8ZRcPAyysy1sjKzYpX9Z7FD5ES9L1MZD/jtcG4YmNTYT
         tYahivtiMy1ZPNeFGYVk30+DaAbU5Zf2OVF7yGQrklBwJvc8CF+z8pJIiUimbuJ/z9L6
         VgaHtpU9yTrXYYHTEz55hLT+gLRt8FUa+efFbWxLZiFTb6DkSkTvuwCi9Ulx8LLcxCZx
         ilwQ==
X-Gm-Message-State: AOAM531TUIUnBqcylC6W+8SVhtlBELvl60LLwm3TBy1uuy6vj/aphLLD
        9HF9YJrmRY2+oR66BoYpTZ1HMvDw2w6K7dNy92ZDBhT2YEIwM8e6HRMzAeONO8sL1be2eppJ288
        Mr9MDNeBFzBIMGSqKXmEVMU+uFRmbqTG56GDEY85qWEz1nCZ5gUcdqoUG
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr12181067lji.191.1600425588776;
        Fri, 18 Sep 2020 03:39:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjdifQSj/on5KrMw8Uc/IRsfoxNs9Bf+W2IqpozLJMGxB4ZcAjvQ0UDDusCs6H/dI1hVNWjY2TLNHtYxHpBrY=
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr12181057lji.191.1600425588488;
 Fri, 18 Sep 2020 03:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200907035010.9154-1-po-hsu.lin@canonical.com>
 <20200907131217.61643ada@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <CAMy_GT-kaqkcdR+0q5eKoW3CJn7dZSCfr+UxRf6e5iRzZMiKTA@mail.gmail.com>
In-Reply-To: <CAMy_GT-kaqkcdR+0q5eKoW3CJn7dZSCfr+UxRf6e5iRzZMiKTA@mail.gmail.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Fri, 18 Sep 2020 18:39:37 +0800
Message-ID: <CAMy_GT-0ad7dnWZ=sVt7kZQSMeKQ-9AXdxTe+LqD4uuFnVd+Vw@mail.gmail.com>
Subject: Re: [PATCHv3] selftests: rtnetlink: load fou module for
 kci_test_encap_fou() test
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

any thoughts on this patch?
It can make the test pass and reduce the failure numbers in
kselftests, it will be great to have this applied.

Thanks
PHLin


On Tue, Sep 8, 2020 at 2:57 PM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> On Tue, Sep 8, 2020 at 4:12 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon,  7 Sep 2020 11:50:10 +0800 Po-Hsu Lin wrote:
> > > The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
> > > needs the fou module to work. Otherwise it will fail with:
> > >
> > >   $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
> > >   RTNETLINK answers: No such file or directory
> > >   Error talking to the kernel
> > >
> > > Add the CONFIG_NET_FOU into the config file as well. Which needs at
> > > least to be set as a loadable module.
> > >
> > > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> >
> > > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> > > index 7c38a90..a711b3e 100755
> > > --- a/tools/testing/selftests/net/rtnetlink.sh
> > > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > > @@ -520,6 +520,11 @@ kci_test_encap_fou()
> > >               return $ksft_skip
> > >       fi
> > >
> > > +     if ! /sbin/modprobe -q -n fou; then
> > > +             echo "SKIP: module fou is not found"
> > > +             return $ksft_skip
> > > +     fi
> > > +     /sbin/modprobe -q fou
> > >       ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
> > >       if [ $? -ne 0 ];then
> > >               echo "FAIL: can't add fou port 7777, skipping test"
> > > @@ -540,6 +545,7 @@ kci_test_encap_fou()
> > >               return 1
> > >       fi
> > >
> > > +     /sbin/modprobe -q -r fou
> >
> > I think the common practice is to not remove the module at the end of
> > the test. It may be used by something else than the test itself.
> >
> Hello Jakub,
> Thanks for your feedback.
>
> For this case I think it's safe to remove the module here, as it was
> never loaded before and thus causing this test to fail.
> If other tests in this rtnetlink.sh need this fou module, we should be
> able to spot those failures too, however this is the only failure as I
> can see.
> (pmtu.sh will need fou module to run as well, but it will be loaded there.)
>
> Shouldn't we insert the required module whenever the test needs it? So
> that we can run the test itself directly, without depending on other
> tests.
> Also, I can see modules for tests were being unloaded in other tests as well.
>
> Thanks
>
> > >       echo "PASS: fou"
> > >  }
> > >
> >
