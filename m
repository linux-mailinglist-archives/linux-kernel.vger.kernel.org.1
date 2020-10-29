Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41929F27B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgJ2RDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:03:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7705C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:03:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 1so1600361ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3n7G+lqhdj2m6ZW7egyophkpDB+wpVSM0ePuVuERRS8=;
        b=HsRM+g6C9J1QGiGakNuf2gdZqEXHe+jU4JgUW2Wskuf+JUvC3OmpwWJQvuB0XL0QkW
         lmRd2YHDP8GM7WZ5uIEFSHESefRBSGcp6+UaRPkNUoFEYuyI+L1FC0o74fWnS8Mkx8+r
         VStvdpe4gr4b8G/OhW7jVQZjWev+xMjbWFMa+YWzd+VlAcJUDeeln2OzH2gbkTyTUNzK
         O2AGppST0Mow0lzoJMtM605EvRePsMZt6d+TBLQ003Jnt6foX9up5pZ/NPK5Sx/c0kpj
         5oqm2GpNyv35YM6B8NDP56zncHPwD9wBwr9cPVIw6rw36csVWh+0aqrPtALaF9pVJp/V
         OwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3n7G+lqhdj2m6ZW7egyophkpDB+wpVSM0ePuVuERRS8=;
        b=pboKk016NFy9URpQm2YaZGRmXw5KD1gs0KvzpCsvu7ngDL4ziKkgjpCnNnIbWJgKyW
         rZLOY5RDq5kZrgHdJ/WeEYDVE4boSEO51NYdlFoV3d9hA8QiPsvpjMSp0E7bsfOmTOfi
         MCs7wHIQae+ER7vqyt0OusKzarhDQVGiTBdn3/Q0/dHpcltnir1mnPRhtLWPKS58Y6m5
         TFDtc//vM31bBeYE+8hAeTdQ5EoD9pV0PY3M8aAgmxCdXONsvUVgZt8IjmXJhQSoSwGo
         QSllzD3mD0YeEAONZx63Epbs/aqyM/PrDduYgomUFWvjZ0zctPbearPCuXmDQRo2JoAV
         Trzw==
X-Gm-Message-State: AOAM531VOT8sxAhiCrdWtmxgA4J2klLit2MJ7cQOhC0PusxhPk51/kIJ
        sBQ8kbITpBf5ccGB1DMJRu+SDpI2I7coSnCphaY=
X-Google-Smtp-Source: ABdhPJwpSjNKrweL/sApWTmLR9sBDeGzOVec3kiRHRAW+HvLUHOCBC3qqQ1bgPFmz7qOrmhNcFjcE8CnddImrxJELh4=
X-Received: by 2002:a17:902:6bc8:b029:d6:d9d:f28c with SMTP id
 m8-20020a1709026bc8b02900d60d9df28cmr4861009plt.17.1603990980254; Thu, 29 Oct
 2020 10:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com> <1603971787-16784-2-git-send-email-mihai.carabas@oracle.com>
In-Reply-To: <1603971787-16784-2-git-send-email-mihai.carabas@oracle.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:02:44 +0200
Message-ID: <CAHp75VcBOt9fVfMd7x_WnMETmr465gA_XFAm=sSy40wexHyRpw@mail.gmail.com>
Subject: Re: [PATCH 1/4] misc/pvpanic : preparing for pvpanic driver framework
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Hao <peng.hao2@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 2:28 PM Mihai Carabas <mihai.carabas@oracle.com> wrote:
>
> From: Peng Hao <peng.hao2@zte.com.cn>
>
> Preparing for pvpanic driver framework. Create a pvpanic driver
> directory and move current driver file to new directory.

Hmm... It was a bit of a long time...
Have you seen [1]?

[1]: https://lore.kernel.org/lkml/20201027175806.20305-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko
