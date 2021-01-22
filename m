Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E792FFE16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAVIXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbhAVIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:23:19 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F172DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:22:35 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e22so9464793iog.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ly5/Q5tFCYCFXPuGXr/jHPdW+egr1n1WZiW++MebkBk=;
        b=e+hiwXE9RVV49cuPdpTjkcWzwQhUuB4cHE18roKxv1GMsABWc3LmiCZ02Wz3JUQIJb
         ncHx+xSxGNC4s4Xh0sF6nlAAgF0wIQsy2TPnwjgZul49xSFEQQOduG2WKmYYeBl17Hnb
         5k/XVvUzyhOkavhdjxO+4WT1aNKC6Pt6k+di2Q/cOHWyVuMB0/M8ZYWcb0RSkPgMlyar
         xIFB9JtV9dW4htQBJtN4Zys2b5iuwKwELbk5S2HblMRwr0MzXUEmQzw/06TVqz5wH+hf
         KA3G0x3nsNl83UsbEB+FwnPjT9Nty66nsWDhkOq48yhWJdL9HjD7s2g5aqzKabxKnjTX
         zfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ly5/Q5tFCYCFXPuGXr/jHPdW+egr1n1WZiW++MebkBk=;
        b=biHyvRRG6Okda+RaypQcBS1uKchdj7HupDhCtlqbD3uf72BY9lhjOWH6DwdA7vIUuc
         XlKsg9XGLb+qroT0khZzOgKzzOf9FYNzk7OsecaE/xBYQ8ZpacfN3q4B+oAbnFoBr8an
         MH50ZdnWu86XjAjwXYk1+XiFAoE2ug6FFPZV+Ih/ERsILXC4ZMAUqK8FRXj/hNnJ18dO
         neTX1KE2ReLl3b+XsYQWlXGVhhT/voGar1MoP0E1eEptc5VK6U872xdU18jqtBq6h0e6
         AuAJQt0/Dmy93wmzUn/WEgpqar692ePxf+NgpDNIf9n7m0KO03aAKbMluibe510XQz3l
         gGUw==
X-Gm-Message-State: AOAM530nduUhnivaYm+dGWNnShFx+6GUO2eiRpraXwD5NZQNdLK41mo5
        eCJmv6Y+QU0IHjFIJ2udKlsk+0dqAv0U2mn+AHzIfUtz+KjdCQ==
X-Google-Smtp-Source: ABdhPJw07Qu0pLknt3B38bDXxgTHeuNiFkdrxRBTZIaqwDy2KTMigVvrhOTkqfox9dDlbmraxuD8wEwI7aYs0pGuwCo=
X-Received: by 2002:a5d:97d3:: with SMTP id k19mr2613022ios.102.1611303755323;
 Fri, 22 Jan 2021 00:22:35 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 22 Jan 2021 09:22:24 +0100
Message-ID: <CAKXUXMyRAer=0S9pxiRs2iF3pdkU8zW=JZw2a+nJJ30iPLPhCA@mail.gmail.com>
Subject: Small student project idea on appropriate integration trees in MAINTAINERS
To:     devel@lists.elisa.tech
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        =?UTF-8?Q?Ba=C5=9Fak_Erdamar?= <basakerdamar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,


here is a small student project idea:


In previous work on MAINTAINERS and process conformance, Pia Eichinger
[1] has investigated: are patches integrated by the maintainers
defined by the responsibilities in MAINTAINERS?

In this project, we are interested in a related (possibly simpler)
question: Are the commits integrated into the appropriate integration
trees referenced in MAINTAINERS?

As I believe, a main difference between considering maintainers and
integration trees is that the information in MAINTAINERS about
integration trees is more erroneous, as it is not used as prominently
as the personal maintainer information, name and email, with the
wide-spread use of ./scripts/get_maintainer.pl. So, correcting those
errors on integration trees in MAINTAINERS is more dominant (but also
simpler) compared to correcting errors on personal maintainer
information in MAINTAINERS.

The answer on the question above can then ultimately be used to
identify which integration tree entries should be added to specific
sections in MAINTAINERS to match best against the actual integration
observed in git.

The factors and metric to determine what is best is of course the
challenging task of identifying a suitable heuristics that is:
  1. good enough to be used to create a change to MAINTAINERS that is
accepted by the community, and
  2. simple enough to be implemented with reasonable effort.

Background:

The MAINTAINERS section includes references, through the T: entries,
to the location of a source configuration management (SCM) tree with
its type, e.g., git, quilt, hg,
For each commit, the kernel git history carries the commit's
integration tree path, i.e., the information through with source
configuration management (SCM) trees a commit was integrated until it
was finally integrated into Linus Torvalds' tree.

Ideally the references in the MAINTAINERS sections are:
  - complete, i.e, all integration trees used for recent kernel
releases are mentioned in MAINTAINERS.
  - sound, i.e., the majority of the commits are integrated through
the trees referenced in the MAINTAINERS sections a patch belongs to.
  - precise, i.e., for each MAINTAINERS section, the majority of the
commits that belong to a  section are integrated through the tree
referenced in that section.

Goal:

We identify and measure to these properties above, completeness,
soundness and precision.

Then, we use that information to determine which integration tree
entries should be added to which specific sections to maximally
increase the three properties.

To evaluate the adequacy of this method, we can obtain feedback from
the responsible kernel maintainers through proposing patches modifying
the MAINTAINERS file, for the additions that we identified as most
relevant (maximally increasing the properties, to a reasonable
threshold of number of patch proposals [to not swamp maintainers
initially] and a threshold on relevance [to not send out minor changes
that are largely irrelevant to the community]).

In this project, we can make use of:

- gitdm [git://git.lwn.net/gitdm.git]: gitdm includes some scripts to
parse MAINTAINERS and obtain the integration tree patch of a commit.

and/or

- pasta [https://github.com/lfd/PaStA]: Similarly to gitdm, pasta
provides functionality to parse MAINTAINERS and some functionalities
on extracting information on commits.

Potential project phases:

- In the first phase (PoC phase), we could probably just create a
setup that combines or extends the functionality in gitdm and/or in
pasta.

- In the second phase (MAINTAINERS patch creation phase), we send out
some patches and collect feedback from maintainers.

- In a third phase, with a better understanding of the individual
pieces in gitdm and/or in pasta, we could then create a cleaner design
that also refactors gitdm and pasta to share the same implementation
when essentially the same basic functionality is used within the
various analyses.


References:

[1] https://lists.elisa.tech/g/devel/message/1269


---

Any thoughts on this small student project?

If it is not too crazy, I will mentor a student on this project
through one of the next mentoring programs (Google Summer of Code, LF
mentorship, etc.).


Lukas
