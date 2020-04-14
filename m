Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE431A8DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 23:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440721AbgDNVrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 17:47:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634112AbgDNVpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586900722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZeGGFPup1XJHwyIEzNEDendxGJK59EpZeVXypI0W67g=;
        b=WD0Si2lCjeir8dlGCL1E/27xgwA6HYew/SPgY5SpoPcmTUv49ZqzzOUotH6IfRx3tAR32Y
        gEFfzbkNgLuOx+7lOE73JeylpJpldENfqjtkdsSO5wHlYH1WQQt6lEaRE7k+MbnteClRKx
        qh+bPf20d3FDRdCpVtb5s/A0jo2kDuE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-NGDt8pjtMOCm38yQoJc3eg-1; Tue, 14 Apr 2020 17:45:20 -0400
X-MC-Unique: NGDt8pjtMOCm38yQoJc3eg-1
Received: by mail-qv1-f69.google.com with SMTP id m20so1143386qvy.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZeGGFPup1XJHwyIEzNEDendxGJK59EpZeVXypI0W67g=;
        b=EVH/e8Lq7cVDUWmLwy7D+nsLACaJ1NbrIGrD5/wDEXbJXs3tJVkCKY6w0hLXthpEmS
         cqAPvMxxC16EtHOa+az7bYSdrKYcch/0FBKDigeKw5NxodswwBtaJiaLAfBJQ5jjHLcr
         nKwfajWarEF7tPeHKO72o7qI9D/1fTWQrREePkt7KJzAHSTxIEPDU700To7ZSMd6Cv0o
         +DteufuReRxxnQO+6PVoiBktLxtNsf9G+V55SqrfUx6Bg9wUou4VwBpK16KV/hTz+Kxq
         U3pDzZaK8Ut0O94/lVtyvrvkWmoUn8SBsvua0DrtbdqNoVr8a8ob8+PbEgR023cXVW0J
         Jcsg==
X-Gm-Message-State: AGi0PuacIZQAZnRsojYb5PJXUdAFnHQ87xur+9e036oM/t9iHCKev6Bg
        pWNauJK1H2BUOHrtYmP6wF5JGMJm3sEQsons6UXe0Ivs1XSVfggWfXmbIDeFg/weW1efD6A2DKH
        1aOZlT8yCz6NazMAK8CFkUBIH
X-Received: by 2002:ac8:19fd:: with SMTP id s58mr13025714qtk.222.1586900719303;
        Tue, 14 Apr 2020 14:45:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypLnIUCv2QyX3WPwS8EK5rktDGhPYL53gRHXyaxrMeQgwGmL+C8SmB9EGuhtZKwhRNIFRi4DHA==
X-Received: by 2002:ac8:19fd:: with SMTP id s58mr13025690qtk.222.1586900719028;
        Tue, 14 Apr 2020 14:45:19 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v5sm11448631qka.106.2020.04.14.14.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:45:18 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:45:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
Message-ID: <20200414214516.GA182757@xz-x1>
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 01:10:40PM -0700, Brian Geffon wrote:
> Hi,
> It seems that userfaultfd isn't woken from a poll when the file
> descriptor is closed. It seems that it should be from the code in
> userfault_ctx_release, but it appears that's not actually called
> immediately. I have a simple standalone example that shows this
> behavior. It's straight forward: one thread creates a userfaultfd and
> then closes it after a second thread has entered a poll syscall, some
> abbreviated strace output is below showing this and the code can be
> seen here: https://gist.github.com/bgaff/9a8fbbe8af79c0e18502430d416df77e
> 
> Given that it's probably very common to have a dedicated thread remain
> blocked indefinitely in a poll(2) waiting for faults there must be a
> way to break it out early when it's closed. Am I missing something?

Hi, Brian,

I might be wrong below, just to share my understanding...

IMHO a well-behaved userspace should not close() on a file descriptor
if it's still in use within another thread.  In this case, the poll()
thread is still using the userfaultfd handle, so imo it's cleaner that
the main thread should pthread_join() on the poll() thread before it
closes the handle.  It can be easily achieved by attaching another
eventfd to the struct pollfds array, and write to the eventfd when the
main thread wants to quit so that the poll() will return on the write
to the eventfd.

On the other hand I'm thinking whether we can achieve what you said.
IIUC userfaultfd_release() is only called when the file descriptor
destructs itself.  But shouldn't the poll() take a refcount of that
file descriptor too before waiting?  Not sure userfaultfd_release() is
the place to kick then, because if so, close() will only decrease the
fd refcount from 2->1, and I'm not sure userfaultfd_release() will be
triggered.

Thanks,

-- 
Peter Xu

