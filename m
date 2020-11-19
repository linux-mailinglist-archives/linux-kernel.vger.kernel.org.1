Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A92B9439
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgKSOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbgKSOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:09:30 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755BFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:09:29 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u21so6167227iol.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mnHOygy1PgffUAB5HlGDF2Tb3dmNcBIqKWkdAUfGyJc=;
        b=lwPsg2sDpOJPI70hHSmB+dTEMb9dqySfIZthlP4l2nbx8Og+9CGYNkQJFkRgKyp1gd
         rpUlmUD62ErZm55fmkfBGUnmKVktlj4AJ+cxYKw1Zwh+i0yqri+fucXRcA6U11gtAYri
         DhrSgRkgy6R1h00pUtslwWzpc9iKtPIeBXsdbnXhml1PLl6RbYh0lFwShIwGXGDFH7r0
         gEpDTDRDmf6fpogKF+rynQOTxabj315/z3zhFvI4vZX/5XrQ5jxy3oOy81XznsTFHilE
         Cf3i5Zqyx3uA+Luij3RkgTrYGBvLLjvlDZloX4XCvS7JyYmahFSJAII9J6FxITa1pz4G
         o9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mnHOygy1PgffUAB5HlGDF2Tb3dmNcBIqKWkdAUfGyJc=;
        b=FUh2+5NWBh/TzNwSsWFk5/M1qwFLFaE1stRw9ADEhtBKeQmeDB96R6bc2QjkF5i+c0
         NL//RsSkX3GgLvZuRGEKhZxqATeqxlXX0BvE1iaCP4jgJdmqGhX45epmuVfS6A+dKmXl
         WFViyTwpuzIysXBSqrcodOHZtyKqDV/yiulvvw0mHKn6DZBdp6URhY3CERn5a4r0sU/q
         EwEb0BgC1Kh/nIg45vP8Gtru8qjnPupSsm+wRcV9I5/hsPWGzJpHe5ylIXISp37fubqt
         qtgGaB+QAPIQfYaviiZegDrRDVCktTkVE6CkIEumS/IyHGKdQ6Iko1z4lhE5dVj4CMWQ
         7XhA==
X-Gm-Message-State: AOAM532d8cGwgSGJwonlFumbBnNK0zq9G0zuBk1cbEXrTe1fpyGZAte4
        XJjD/4PiGZPf+5yzHhtQvYx5Z2fuCBCc04hkXEsObGxPyPc=
X-Google-Smtp-Source: ABdhPJzrsut7xyNpH0TErjEhbNebEapRN3i4cl4BbfhrvgNGSSo0O24GiFzP1fjbvrvaadLioOtpvvrSKfUKCZJT7SQ=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr9145763jac.69.1605794968544;
 Thu, 19 Nov 2020 06:09:28 -0800 (PST)
MIME-Version: 1.0
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 19 Nov 2020 16:09:17 +0200
Message-ID: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
Subject: Proposal for a new checkpatch check; matching _set_drvdata() & _get_drvdata()
To:     apw@canonical.com, joe@perches.com,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

So, I stumbled on a new check that could be added to checkpatch.
Since it's in Perl, I'm reluctant to try it.

Seems many drivers got to a point where they now call (let's say)
spi_set_drvdata(), but never access that information via
spi_get_drvdata().
Reasons for this seem to be:
1. They got converted to device-managed functions and there is no
longer a remove hook to require the _get_drvdata() access
2. They look like they were copied from a driver that had a
_set_drvdata() and when the code got finalized, the _set_drvdata() was
omitted

There are a few false positives that I can notice at a quick look,
like the data being set via some xxx_set_drvdata() and retrieved via a
dev_get_drvdata().
I think checkpatch reporting these as well would be acceptable simply
from a reviewability perspective.

I did a shell script to quickly check these. See below.
It's pretty badly written but it is enough for me to gather a list.
And I wrote it in 5 minutes :P
I initially noticed this in some IIO drivers, and then I suspected
that this may be more widespread.

The shell script gathers a list of xxx_set_drvdata() functions then
greps through all files and also checks if there are any matching
xxx_get_drvdata().

Thanks
Alex

Shell script:
-----------------------------------------------------------------------
#!/bin/bash

fns1=$(git grep _set_drvdata | cut -d: -f2 | cut -d'(' -f1 | sort -u)

for fn in $fns1 ; do
        if [ "$fn" == "//pci_set_drvdata" ] ; then
                continue
        fi
        if [ "$fn" == '``dev_set_drvdata' ] ; then
                continue
        fi
        if [ "$fn" == '"pci_set_drvdata' ] ; then
                continue
        fi
        if [[ "$fn" == *"_set_drvdata" ]]; then
                fns2="$fns2 $fn"
        fi
done

fns1=$(echo $fns2 | tr ' ' '\n' | sort -u | tr '\n' ' ')

for fn in $fns1 ; do
        get_fn=$(echo $fn | sed 's/_set_/_get_/g')

        echo "Matching $fn - $get_fn"
        for file in $(git grep $fn | cut -d: -f1 | sort -u) ; do
                if ! grep -q $get_fn $file ; then
                        echo "   Maybe $file"
                fi
        done
done
-----------------------------------------------------------------------
