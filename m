Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D06628CABA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391390AbgJMJBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388779AbgJMJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:01:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD8C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:01:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h19so5437445qtq.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzlx1lSw3l/6Ur8/Sn7ci35fsubD9X5O/MsTrgWbq/A=;
        b=lyoXVelQPGYTd0r89zDkQ2FvpuVookCeu64uQ+zQJlN0FF8VeSfJLpyqsG8Wjy/hyU
         LOy+dPL3O4rv755sxir4iMZ9mAJYTTcTjR7hbSdHCVjMQSJczwraeL9ZRPfA8WZSPpBl
         3uSstbyqDPTIV44nfwCddGxU9qpHV4J2tZBiLFeRdoz/hFtErLYnVQ0UPsb1Qzq8v0Aa
         uc1PcqgX2+C/gZ1Ni740WGMa7k9mkKJUmAmT7RicrUH6TH+NsSxSCN31FT4W2lBy4w81
         oD6UNjAULZrxlpUmhAhFhUHNwllFqtwhSi0wHfackvR4aSkwEXiIyKZIqUVVecconevA
         QmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzlx1lSw3l/6Ur8/Sn7ci35fsubD9X5O/MsTrgWbq/A=;
        b=Vvf49/ZrG/yiiaC+bBULGMY5jbjHr52wyJYWTposX6raU2Rckaav4/oixn4U8AUJyi
         HP5Z5HhdFdw55j0z04ihawJKvoNtBDCbKcwetQFmMQpf/NQlO8IKh0e+DiLxvuPUErW9
         0ZFgZ1FFg6uzJfAWKJWkoTtbwW8i+lYGstQNQ87oqQxsrUvLpi1Qh2/pqjutIhPjzCit
         M9UGJrolnRrANgHLc7pwZxKzyB6CyghGfb2ccNwtB1awVZWgFbcdIbGEco555Tr7GZij
         3JHgkOUb8xySoYq8cJwdZnb8OhYc39DtHxreqvi0xgZl8/ZdCOy+TaEVb4Da23H+0ArI
         EHpA==
X-Gm-Message-State: AOAM533MxSZA2+cgWLogWEjCnxXX7MBZVfXcjSw8O8ZuKC0vtSNMfT+W
        WUsy9AeK+WxGjV42me/afPgOUNYMtnmCby3wdtY=
X-Google-Smtp-Source: ABdhPJwrGUDHLSMDdLLQTnfIfEqHbv3h5j+c8n5NdDUiWlqhLrqp9pDsJ3BfBBDLbtxyzeW8C41j0rvAQBfxB+U4yno=
X-Received: by 2002:ac8:4246:: with SMTP id r6mr14394610qtm.129.1602579693242;
 Tue, 13 Oct 2020 02:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201008182713.2764-1-harshalchau04@gmail.com>
 <20201009045734.GA112189@kroah.com> <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
 <CADVatmOf18xUEvjWFzenut=KsHtoEZ5OSZF1oCqFJsbkx_Mb9g@mail.gmail.com>
In-Reply-To: <CADVatmOf18xUEvjWFzenut=KsHtoEZ5OSZF1oCqFJsbkx_Mb9g@mail.gmail.com>
From:   harshal chaudhari <harshalchau04@gmail.com>
Date:   Tue, 13 Oct 2020 14:31:21 +0530
Message-ID: <CAFEvwukbxCY4wffd_1jLo+vjfXfBC4sFDpJ1vY4wfT+=yFA--w@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: check if ioctl argument is present and valid
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 2:41 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> On Sat, Oct 10, 2020 at 1:08 AM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > On Fri, Oct 9, 2020 at 5:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Oct 08, 2020 at 11:57:13PM +0530, Harshal Chaudhari wrote:
> > > > Checking the argument passed to the ioctl is valid
> > > > or not. if not then return -EINVAL.
> > >
> > > Along the the comments that Arnd made, this is not the correct value to
> > > be returning from an ioctl when you don't pass in the correct command.

Thanks Greg for the comment. i am checking with value
-EFAULT now, i will get back to you with changes as consideration
of Arnd comments.

> > > And it doesn't match what your patch says, please be consistent.

I just want to perform the Argument check here only.  back then i
was trying with access_ok() as well, but access_ok() return success
even if i passed a NULL pointer. so that's why i removed it from here.

> > > And do you have this device to be able to test your changes?

Yes I have a device and I tested these changes with the few ioctls.

> > I will test this tomorrow. But from an initial look, its going to
> > break ppdev. There are few ioctls which don't need any arguments.
>
> No, sorry. I missed the check for _IOC_NONE.
> Tested on a desktop which has a parallel port with a very basic test
> code of open->claim->write->release->close and it still works.

Thanks a lot Sudip for your time.

> --
> Regards
> Sudip
