Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9892A575C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbgKCVmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732055AbgKCVmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:42:10 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC28AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 13:42:10 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id j6so4574507oot.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XcUyzRSkQdfCPUitCynwKGSNZmdBQU3N/HuyOVpoBT4=;
        b=C45j2rRzoa9Nz619ySMvuHEABzW0CRp9CH+pwcHAcRsSrySwgISlBDHvRDxJgN6yMn
         6iN9v5PmBPekgnodQQlml/T+k1Mt57ubXWkO3OZQ8G/cXk/ouIZ1Ls8PyDAQgKMdVicx
         hidJmUqAbNgmOPqbV28faKDYii/0CSlDbZ5wyLEUd73EbY5jcP82tv6v5JiK/7ihcuE9
         RqGmh64elVv0/mOnqfDou5tgEOfdDDLdO+sUCWWRE0dJkUynn2dDTj5ccyvUiljpuxiG
         lorz2QX8XKIcBlM/gamQE7cczdq9Gqxq7zz1NAuvcROZOy1XWM0DB4qPp99wgf6w2qew
         9vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XcUyzRSkQdfCPUitCynwKGSNZmdBQU3N/HuyOVpoBT4=;
        b=bq8WSvoB0ZFsl7LLJAKdKydTHo0b+cU0O8phWCXmaJd2FMSM6tNWstvBDypg3+Bx7t
         5cwwYYoRBbvaaAUI+lle2zH25bTNy2lVhypATfvYY4JmEQqChWtH87EnQmfgCXS9oDoV
         ZZQzAXHir3BFO99DU6N+oAG9K3/dUdr6h2ZrB0BOy7UG8gJj0L1x8zjnHmOCtNHLJ1m+
         oAUS04/kURZ4Cp6h+f10bqv0APndUJU5Xr4zdiXC3YbjmGdWjO/7iMd4FT5g0p5V2+/0
         uPh3B1+I/BpHNHdR3MvWERxeVuLJGy71eW1WzbZ/LcQ8iuYdxJP6rjSDOG++2+28kjWX
         al2w==
X-Gm-Message-State: AOAM532vs7nUUGnn8AZVwY83E8MI31uPfIB+Q8ogsh+ndvXnyTJhZCD3
        z9CTsgLTansMjgXs1561+JN904ectn3K+NSNApiveZp90CU=
X-Google-Smtp-Source: ABdhPJx6V0n3ntjA+9GnDAgFTjaWsyPRqSy3inPeQVaCmAEFC/iVWuOkUELUYCqBEij4LY6g2IKeceW/VwEpozJSZmE=
X-Received: by 2002:a4a:95cb:: with SMTP id p11mr16762418ooi.89.1604439730123;
 Tue, 03 Nov 2020 13:42:10 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 13:41:59 -0800
Message-ID: <CAE1WUT4SD8gBCzf1tKK0acV4iXmVq4FF8Z6RNex65Ntxgzb0Jw@mail.gmail.com>
Subject: Directory category for accessory drivers
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently working on improving some accessory drivers to hopefully
submit to a future kernel tree. The drivers are assorted for headphones,
mice, keyboards, and other assorted accessories. Which driver category
or folder would this fall under, or would they require their own new folder
on the drivers/ folder level? If such is the case, what should said folder
be entitled?

Best regards,
Amy Parker
Please refer to me using singular they/them/theirs pronouns.
