Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0882A2B38
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgKBNIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:08:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:11043 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgKBNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:08:05 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201102130803epoutp0289208b1ebda06e08f027c17db6422a31~Dssxav21N1081910819epoutp029
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 13:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201102130803epoutp0289208b1ebda06e08f027c17db6422a31~Dssxav21N1081910819epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604322483;
        bh=CD9APafwRkBcLepB/+tUMgO9fh9Ebz5nhA93UNh3oNk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JBA30Zlh8lLvS5F3d0/gsRi/8pkE3WaxngD19hMQGPYAKhhlZT+IBWFgWxsKvA6sg
         3lBthqC3De+OPCds5U76pYYQ1g3FNY3IpQZwF0lKA3pXDKU9n/DVj5xkQxzsko1SVD
         43RIP8oq4wLEVoJi/VQVxvd/qXImwNLfWbCviXIg=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20201102130802epcas5p1fd165479d82a0b7e4f7d6b5d0843e022~Dssw9wS5A2109521095epcas5p18;
        Mon,  2 Nov 2020 13:08:02 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.04.50652.2B400AF5; Mon,  2 Nov 2020 22:08:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20201102130802epcas5p1c9d930815905100d7dd38e6f61759135~Dsswn_UeK2109521095epcas5p17;
        Mon,  2 Nov 2020 13:08:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201102130802epsmtrp1b0863da5afe8ba93df24738b66dbb867~DsswnYfaA2982829828epsmtrp19;
        Mon,  2 Nov 2020 13:08:02 +0000 (GMT)
X-AuditID: b6c32a4a-c49f1a800000c5dc-64-5fa004b24d5a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.04.13470.2B400AF5; Mon,  2 Nov 2020 22:08:02 +0900 (KST)
Received: from alimakhtar02 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201102130801epsmtip1db36d4e9976bdeb8748ea00baa8cce11~DssvoMlae0851108511epsmtip1e;
        Mon,  2 Nov 2020 13:08:00 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Lee Jones'" <lee.jones@linaro.org>, <martin.petersen@oracle.com>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Santosh Yaraganavi'" <santosh.sy@samsung.com>,
        "'Vinayak Holikatti'" <h.vinayak@samsung.com>
In-Reply-To: <20201102115728.1077697-12-lee.jones@linaro.org>
Subject: RE: [PATCH 11/19] scsi: ufs: ufshcd: Fix some function doc-rot
Date:   Mon, 2 Nov 2020 18:38:00 +0530
Message-ID: <0c1c01d6b119$31c98f00$955cad00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHd3Sj0F5ZbVb9xf4pNoM5m4W3t3wFg2ETCAtKS9bOphNwawA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZdlhTU3cTy4J4g20TZS1e/rzKZnH/61FG
        i8u75rBZLD/+j8mBxePOtT1sHh+f3mLx+LxJzqP9QDdTAEsUl01Kak5mWWqRvl0CV8a2L/fY
        C7ZzVhz+dYuxgbGDo4uRk0NCwETiy4z3rF2MXBxCArsZJc5u3csE4XxilJg1t4EFwvnGKPHh
        zXe2LkYOsJbX/0Qh4nsZJS59m8kI4bxklJgz4wEjyFw2AV2JHYvbwBpEBNwkWiZFgdQwC6xl
        lJjS8owNpIZTwFbi0d75YLawgLvEwy232EFsFgEViWsX7oHZvAKWEr/nXGaFsAUlTs58wgJi
        MwvIS2x/O4cZ4gcFiZ9Pl4HViAg4Sbzofc8OUSMucfRnDzPIYgmBn+wS/859ZYRocJGY134R
        yhaWeHV8CzuELSXxsr+NHeLLbImeXcYQ4RqJpfOOsUDY9hIHrsxhASlhFtCUWL9LH2IVn0Tv
        7ydMEJ28Eh1tQhDVqhLN765CdUpLTOzuZoWwPSSmPdrCNIFRcRaSx2YheWwWkgdmISxbwMiy
        ilEytaA4Nz212LTAKC+1XK84Mbe4NC9dLzk/dxMjOLloee1gfPjgg94hRiYOxkOMEhzMSiK8
        NZHz4oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzKv04EyckkJ5YkpqdmlqQWgSTZeLglGpgMpEw
        Vm5U9S9x2MfY2/CUp2uraPLqnyKvopdej9660bx2/83G539mv+e6KvbU0cg6NUJ228YAn938
        k6flr/71O4HV//IHwfy4B64Hzlq91fvM9+FC+M8NhVvva0o+Fl3afuFzYMcUkeq8pe0pppO+
        8xZ9md8+9U1Ux5H2uwGJPC/vGn+Xfzndotig7pTlnscbNOXiXeLEnERKpOa4npJRZgzX/Jwb
        ILyZw1X3urdR7vPH959FS5wM9L/ifZzrxZKP6rrTRdNcVbeJl/w+1DNxL8fRszVrb07ymCyh
        ueP2gaOqFlf18pXU899lbWI+VHIpPdP4KvfxbX8aZr8T8Ime1/umT7FesZzr7v6H1v/YlFiK
        MxINtZiLihMBV2RPyZ0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnO4mlgXxBp/Ws1m8/HmVzeL+16OM
        Fpd3zWGzWH78H5MDi8eda3vYPD4+vcXi8XmTnEf7gW6mAJYoLpuU1JzMstQifbsEroxtX+6x
        F2znrDj86xZjA2MHRxcjB4eEgInE63+iXYycHEICuxklLv/hBbElBKQlrm+cwA5hC0us/Pcc
        yOYCqnnOKNGxZB0LSIJNQFdix+I2NhBbRMBD4sLtm2A2s8B6RokH83khGvYxSrQ8hJjEKWAr
        8WjvfLAiYQF3iYdbboHFWQRUJK5duAdm8wpYSvyec5kVwhaUODnzCQvIocwCehJtGxkh5stL
        bH87hxniOAWJn0+XsULc4CTxovc9O0SNuMTRnz3MExiFZyGZNAth0iwkk2Yh6VjAyLKKUTK1
        oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4QrQ0dzBuX/VB7xAjEwfjIUYJDmYlEd6ayHnx
        QrwpiZVVqUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgtgskycXBKNTCdWVvWXygp
        vIntVtoxA7H4o4dSk81TdvM4npmhcE5gsfcif33FrmUlEhEWQXzzkks+HRfYsVs3Yk/b9Nr/
        y1173+wPCvXudBLRFZ92XWa71e6d5iIeDxX2bXiYfKR3+77aW3cvmYXe4roef38L51UB9zlu
        DD+uO62Qquya92PG5GrDM6otKy80Lr6a5HnoqMHZBa25xg7biw4a6a+86p7590z83qvvThRZ
        TmITuyPmzVO1UumDwhue6M7nM655yJjP7j1wQXnRK0GOuH+7t8+p3G57oUGwKHFL+Pz/u6e/
        YeGY5OU+KXMxT3CBdeTFtpmHHtabzn3lPVVDQuulO5PKKotTTjuVTPaGrgiLmO+qxFKckWio
        xVxUnAgAazl5GP8CAAA=
X-CMS-MailID: 20201102130802epcas5p1c9d930815905100d7dd38e6f61759135
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20201102115749epcas5p2f6dadc1e6a55938e1ce66f87e7b2c6ea
References: <20201102115728.1077697-1-lee.jones@linaro.org>
        <CGME20201102115749epcas5p2f6dadc1e6a55938e1ce66f87e7b2c6ea@epcas5p2.samsung.com>
        <20201102115728.1077697-12-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> -----Original Message-----
> From: Lee Jones <lee.jones@linaro.org>
> Sent: 02 November 2020 17:27
> To: martin.petersen@oracle.com
> Cc: linux-kernel@vger.kernel.org; Lee Jones <lee.jones@linaro.org>; Alim
> Akhtar <alim.akhtar@samsung.com>; Avri Altman <avri.altman@wdc.com>;
> Santosh Yaraganavi <santosh.sy@samsung.com>; Vinayak Holikatti
> <h.vinayak@samsung.com>
> Subject: [PATCH 11/19] scsi: ufs: ufshcd: Fix some function doc-rot
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/scsi/ufs/ufshcd.c:6603: warning: Function parameter or member
> 'hba' not described in 'ufshcd_try_to_abort_task'
>  drivers/scsi/ufs/ufshcd.c:6603: warning: Function parameter or member
'tag'
> not described in 'ufshcd_try_to_abort_task'
>  drivers/scsi/ufs/ufshcd.c:6603: warning: Excess function parameter 'cmd'
> description in 'ufshcd_try_to_abort_task'
> 
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Santosh Yaraganavi <santosh.sy@samsung.com>
> Cc: Vinayak Holikatti <h.vinayak@samsung.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
Thanks!

Acked-by: Alim Akhtar <alim.akhtar@samsung.com>



