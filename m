Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFB2F58F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbhANDIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbhANDIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:08:01 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E8AC061575;
        Wed, 13 Jan 2021 19:07:21 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x5so3987909otp.9;
        Wed, 13 Jan 2021 19:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wt4c3hj4ZNh4hMLpR61yHCrDZAWL6JHj7ZjRuFGj1Pw=;
        b=fBsj0RnZa25qYcgFyptF/Ij/98L05uF/+BBI0N0B+3SuTyalm+A3fl6HDAqOhe+OyR
         sWGebKw6B7VLU+UU2zP0MsjnS7Bs2xSQkurR2HRx2qugh8TD5e1GWD2SEhqbASOpvDKF
         JOr0GHl0ebEaASF7MMtIkWxwBvcViT5X0QkSGKujZar59berdPvDYDgJ7E5sYG42zC8Q
         JpAnF01i1kzJEXa9XYY6bT8pIfe7hK5H7KYQTyKPyuzEl2Z3B3nsImO0Z21Et7mswboW
         kbVDjLlAsonlg+X2HWDvDnVYgHhgQdEyISIXR4Qpxy7EFBybh2dai0de8FTTawMziwZU
         bnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wt4c3hj4ZNh4hMLpR61yHCrDZAWL6JHj7ZjRuFGj1Pw=;
        b=foAOqK1K+CoPPa8kq5bKGBKLSoxgxk96BDOiyzvllA9FZgFovPVFv9XxnNB5Pk3ldw
         8SOl8dgNElXuc97DSwxL8jVhOPkm+2dOxuEV8Ev8Qde0N+5W5XDwBR4AkwzqWA9lAkJf
         vBxb56jAOlOohdKCF6V9Z6KN66XZT5aPHXCn9ISHw24e7uM8LWfEIz2fuPG6H7XLA3w3
         m40jhFeQoA4FH1hR9OcoltuNIo1HlfFjWw5qcVvat3xjF6wQZOePX44uhpVorUNSfms/
         9sxMEA+unmm6CQlKQQfZ1Ag/K2k+au4ApJpfnil+Fa3ckMz1fSdPEDF8FY+qg9LtpVSN
         92oA==
X-Gm-Message-State: AOAM533/9B81bNhJ1jcHVM8g3aEnmrP2QcSTnfbwQYDu28PDqrmjOOaC
        16lh7NjCUjJ9VtYThEBPgEo=
X-Google-Smtp-Source: ABdhPJxF0kTUTYxrv+YeLvUo0YQUlV/1rUkKv3GXl1lH1tr0FVEujO5BYSs07NnlMKqzAAMElY1+QQ==
X-Received: by 2002:a9d:7407:: with SMTP id n7mr3276817otk.189.1610593640069;
        Wed, 13 Jan 2021 19:07:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u76sm817425oia.48.2021.01.13.19.07.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jan 2021 19:07:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jan 2021 19:07:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hudson <skrll@netbsd.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] usb: dwc2: Fixes and improvements
Message-ID: <20210114030715.GA102157@roeck-us.net>
References: <20210113112052.17063-1-nsaenzjulienne@suse.de>
 <CAD=FV=VnsVgTGTkr9VYQHCkBSVVksT1UGfsmk+dqTyQ1sqF=Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VnsVgTGTkr9VYQHCkBSVVksT1UGfsmk+dqTyQ1sqF=Qw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 03:20:55PM -0800, Doug Anderson wrote:
> Hi,
> 
[ ... ]
> 
> It's been long enough ago that I've forgotten where this was left off,
> but IIRC the 3 patches that you have here are all fine to land (and
> have my Reviewed-by tag).  However, I think Guenter was still tracking
> down additional problems.  Guenter: does that match your recollection?
> 
> It looks like there are still bugs open for this on our public bug tracker:
> 
> https://issuetracker.google.com/issues/172208170
> https://issuetracker.google.com/issues/172216241
> 
> ...but, as Guenter said, I don't think there's anyone actively working on them.
> 
> I'm not really doing too much with dwc2 these days either and don't
> currently have good HW setup for testing, so for the most part I'll
> leave it to you.  I wanted to at least summarize what I remembered,
> though!  :-)
> 

The patches in this series still match what I had in my latest test code,
so it makes sense to move forward with them. I don't think I ever found
an acceptable version of the DMA alignment code.

Guenter
