Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502C1271889
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 01:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgITXGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 19:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITXGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 19:06:45 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A7C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 16:06:45 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e14so7043152vsa.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOrxxsIlfWMIqkpa+MnfRjgVpvXeXQZv+XLbJqLAwLI=;
        b=NGOeJf1evZSbEXW5Ur2acYaTSWcx78uQiXFJUcDhriH6X68AWheo03BhTCzZ3uHwvo
         poPTeKX5+b81f5q3YOwUYECoPREWuBe3bHGZxyMl2NrkrdKkTKcNLOfDGoC681zDL7oc
         AAXPAXTj0VVqMiWJRcdhtajXWOFlR3iWkzB18Y8HLkNeMVxhHePUVoDVjed5A3nLOizr
         j4dwpXGh7mzl8tEI2baAlNRPJMwbVEfAqlDzsM4dcpxz++0c8834f4zNpQdUJ2OP0xsz
         6wIc97gsR4V6S88rPNtDbsA9clblSGqVOe+XznTo66f8Te+IQI8btjeKEh+5/RDaKINr
         XumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOrxxsIlfWMIqkpa+MnfRjgVpvXeXQZv+XLbJqLAwLI=;
        b=kh+R6w+mR+q4Cp3NWrBM+1nd1wyBzOQeAvwqFihbW7ckMFi3za96p7Ak+TZ0n8DalU
         TOKvNUCLJ1Wde1IfYIls4+et4utEYDvHs9mBjYVYTI2weN8uJjXogVbZv0dkVa/D/Cx7
         rQX6ovh4PnXnP/WSKcRa6riF8JFHa9PB8hGEcS7799EeSBrPU0HPDWFR1+f8Kz0t1rtR
         1DUzIilK3dHr5WPnKYhVLktWIz6N+MKnCBDrqWbAluoO0/uRb5plAH4am6jO7j1DvVJi
         amBmln/DOaV4doMQALFNC57kGsHPgxk9/XMjL7oRjjq7wR9cMJus0I3j+zvy4WqAF3Sy
         GFPQ==
X-Gm-Message-State: AOAM532r8F3pG3/elIsHsFFZiowb86VI6KKhZ2QW3Alam5A7N9p45F2B
        PjADQphxP6vXAapfRc2sUdouBYXKiPtx++e2VPvIlQ==
X-Google-Smtp-Source: ABdhPJw9zNfBYUruckqWVVKSTcL4RxIP4p/s8rFKp1NmjRyzZGd0H4QzcreEm48im22qVBNHsX6paGddy4Hb835vZzM=
X-Received: by 2002:a67:ee1a:: with SMTP id f26mr17691801vsp.48.1600643201580;
 Sun, 20 Sep 2020 16:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200917101856.3156869-1-badhri@google.com> <20200917101856.3156869-5-badhri@google.com>
 <20200920140936.GC2915460@kroah.com>
In-Reply-To: <20200920140936.GC2915460@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Sun, 20 Sep 2020 16:06:05 -0700
Message-ID: <CAPTae5L4UuVDwuVRec1-t3FYMfPMDxhnYY7CJ9gSnhZzHJKH+A@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] dt-bindings: connector: Add property to set
 initial current cap for FRS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Yes. Have CC'ed all the DT maintainers for v8. Was waiting to see if
it was OK code wise.
Heikki had given his reviewed-by tag on v7.

Thanks,
Badhri

On Sun, Sep 20, 2020 at 7:09 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 17, 2020 at 03:18:50AM -0700, Badhri Jagan Sridharan wrote:
> > This change adds frs-typec-current which allows setting the initial current
> > capability of the new source when vSafe5V is applied during PD3.0
> > sink Fast Role Swap.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > Changes since v1:
> > - Changing patch version to v6 to fix version number confusion.
> >
> > Changes since v6:
> > - Removed the redundant usb-connector.txt that I created by mistake.
> > - Moved to yaml.
> > ---
> >  .../devicetree/bindings/connector/usb-connector.yaml   |  8 ++++++++
> >  include/dt-bindings/usb/pd.h                           | 10 ++++++++++
> >  2 files changed, 18 insertions(+)
>
> Don't you need to cc: the DT maintainers for new DT bindings?
>
> thanks,
>
> greg k-h
