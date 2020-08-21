Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56C624DB71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgHUQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgHUQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:20:48 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C592C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:20:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u126so2244566iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BFgLAsnF1li7m4vAoiXUX3v+I+43ELkCHNO8Uii8l/k=;
        b=ja6lYmQl/5PQscWBTLB+PYAGkw5+2xzqpgIRY610wXwfTZ9RIxqSq7uH3lT9CNeexC
         XOvNEXdzGK5o2huUVL5GFqyOrYwitnpkFRVKjsvhVVzdXVr0vT/cmHk+YJaHrn/JaQNM
         1U+Bxj7Ozdqk00R4+cZQ3UWA3pPgvTGQ6RXrJGSUBxqEmAW+Cg/PPYGT6ywvRPjjVOc3
         zrU26+GfybdSVZncXtwBrzp3OspcGa9Xp5FLfsZNuFtAnv/sPTIIz3llQSgevglJTQqK
         F3l7MrqqfY2WKWerkaML37hOux9znLi3jYOBHZODzo3aR/lVASXZ0UjawQBzkEbQPuPI
         75oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BFgLAsnF1li7m4vAoiXUX3v+I+43ELkCHNO8Uii8l/k=;
        b=QDxCIqrduVKGv3z9frRWKSgOCaiPpYNz+F5LscMOAOt2qTwLaKpIu/vcBpLLxHpaXG
         tWxXcjZKgG7NtWepKWWJ87w89219gL+xwafyeJ91eqgOQXNH2v24ZCxFILh9YRXurXO5
         urM67dcvnRWTDt8lGCE1Z9xuy34NICchq4ujCpE5hTmQaLptS+usdHVqpH328Ep8+cWR
         85fnO3tJKDiMbl3j3A6MNh9s+3pYwWZuROnPe0wWVRkdW/FIPRG6TGvB94X07UPl6S2W
         XNYKZGX9mxe95S3uEw5Pyqe/+Zk/5Gh8fa5e9Gs4xaEWbt5wyfVbuwwrNU7h8kMcOGWP
         DwoQ==
X-Gm-Message-State: AOAM531UgKug7oZY6yBRVihjeTegg8McKVIaEnwVkhK9zRjMQKAGO6yR
        aGn75v/DCJkQz45Nb8yfluZIXhco7XQ296ur5jY=
X-Google-Smtp-Source: ABdhPJyaagi0KJNoXQ64i12AWRJuDpWm+R14x8+y2wUYlY/BIzaKPc90psn3E8eZlGAJJw/KexQQpLhIrogPYLDuZpI=
X-Received: by 2002:a02:e4a:: with SMTP id 71mr3144580jae.133.1598026847596;
 Fri, 21 Aug 2020 09:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <b360242d-f488-da51-9d47-36b2abdf90cd@kernel.org>
 <20200818160401.4736-1-ztong0001@gmail.com> <20200821092844.GB2026@suse.cz>
In-Reply-To: <20200821092844.GB2026@suse.cz>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 21 Aug 2020 12:20:36 -0400
Message-ID: <CAA5qM4BOn2Kie6chjC4e6A2Sc6Pe61hP8=JKiW7ohYNMnLaC8Q@mail.gmail.com>
Subject: Re: [PATCH v2] tty: ipwireless: fix error handling
To:     dsterba@suse.cz, Tong Zhang <ztong0001@gmail.com>,
        jikos@kernel.org, dsterba@suse.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 5:29 AM David Sterba <dsterba@suse.cz> wrote:
> This paragraph should not be in the changelog. The patches to ipwireless
> go via Greg's tree, please send an updated v3 so he can just apply that
> without further edits.  Thanks.

Thanks David! I've made another patch - hope this one works.
