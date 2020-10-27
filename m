Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3A29A71F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406303AbgJ0I6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:58:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404535AbgJ0I6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:58:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R8n2OV131181;
        Tue, 27 Oct 2020 08:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=roqhxHxZ4UuhbZ5mAkfdDWT1iDjQvTgV06hbLpm6e0o=;
 b=oJQPwS0pmawKTeoOl0+Tr30lKJNlt7BQqHf7hCYbEfbQBBbPCR5dDFBnUgTgazldAz/Y
 5IdmVYemdSXVmxbB/OkAOhVwX5eOsILybX2BWNxsXvFqitEH2tFY3o9vqH8wGF27SkSf
 MYq1mOVB9l+Hc33ynNn4cDwVpr0jVBNsuQKhswNs6u7/j2MD2pwLtp837SeEBu0F+S7F
 4Dr/5c+rnAqOFezFeCMpkec2gVOfo8MMoio2NUlFNiVZ460T5ENi1uF/MLLkebFFewuf
 uMnb4cbKlT20SFUYcmAatr7WWn0+/bcAbrUIKwwLEa0lkf9oB3YX6GwwTx6Jm7xZeooq vQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7krs9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 08:58:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R8oKh5130703;
        Tue, 27 Oct 2020 08:56:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34cx1qfeea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 08:56:23 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09R8uL44011396;
        Tue, 27 Oct 2020 08:56:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 01:56:20 -0700
Date:   Tue, 27 Oct 2020 11:56:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Badhri Jagan Sridharan <badhri@google.com>
Cc:     lkp@intel.com, Dan Carpenter <error27@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: drivers/usb/typec/tcpm/tcpci_maxim.c:324 max_tcpci_irq() error:
 uninitialized symbol 'irq_return'.
Message-ID: <20201027085613.GN1042@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="E5RiUMWuxyMNPNnv"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E5RiUMWuxyMNPNnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9ff9b0d392ea08090cd1780fb196f36dbb586529
commit: 6f413b559f86a2894188e082e389ff95ee428345 usb: typec: tcpci_maxim: Chip level TCPC driver
config: nios2-randconfig-m031-20201016 (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/usb/typec/tcpm/tcpci_maxim.c:324 max_tcpci_irq() error: uninitialized symbol 'irq_return'.
drivers/usb/typec/tcpm/tcpci_maxim.c:407 max_tcpci_probe() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/usb/typec/tcpm/tcpci_maxim.c:408 max_tcpci_probe() warn: passing zero to 'PTR_ERR'

vim +/irq_return +324 drivers/usb/typec/tcpm/tcpci_maxim.c

6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  301  static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  302  {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  303  	struct max_tcpci_chip *chip = dev_id;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  304  	u16 status;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  305  	irqreturn_t irq_return;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  306  	int ret;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  307  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  308  	if (!chip->port)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  309  		return IRQ_HANDLED;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  310  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  311  	ret = max_tcpci_read16(chip, TCPC_ALERT, &status);

Can status be zero?  If it is then then "irq_return" is uninitialized.

6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  312  	if (ret < 0) {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  313  		dev_err(chip->dev, "ALERT read failed\n");
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  314  		return ret;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  315  	}
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  316  	while (status) {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  317  		irq_return = _max_tcpci_irq(chip, status);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  318  		/* Do not return if the ALERT is already set. */
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  319  		ret = max_tcpci_read16(chip, TCPC_ALERT, &status);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  320  		if (ret < 0)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  321  			break;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  322  	}
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  323  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07 @324  	return irq_return;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  325  }
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  326  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  327  static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  328  {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  329  	struct max_tcpci_chip *chip = dev_id;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  330  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  331  	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  332  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  333  	if (!chip->port)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  334  		return IRQ_HANDLED;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  335  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  336  	return IRQ_WAKE_THREAD;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  337  }
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  338  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  339  static int max_tcpci_init_alert(struct max_tcpci_chip *chip, struct i2c_client *client)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  340  {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  341  	int ret;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  342  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  343  	ret = devm_request_threaded_irq(chip->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  344  					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  345  					chip);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  346  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  347  	if (ret < 0)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  348  		return ret;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  349  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  350  	enable_irq_wake(client->irq);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  351  	return 0;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  352  }
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  353  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  354  static int max_tcpci_start_toggling(struct tcpci *tcpci, struct tcpci_data *tdata,
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  355  				    enum typec_cc_status cc)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  356  {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  357  	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  358  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  359  	max_tcpci_init_regs(chip);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  360  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  361  	return 0;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  362  }
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  363  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  364  static int tcpci_init(struct tcpci *tcpci, struct tcpci_data *data)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  365  {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  366  	/*
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  367  	 * Generic TCPCI overwrites the regs once this driver initializes
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  368  	 * them. Prevent this by returning -1.
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  369  	 */
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  370  	return -1;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  371  }
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  372  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  373  static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id *i2c_id)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  374  {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  375  	int ret;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  376  	struct max_tcpci_chip *chip;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  377  	u8 power_status;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  378  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  379  	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  380  	if (!chip)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  381  		return -ENOMEM;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  382  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  383  	chip->client = client;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  384  	chip->data.regmap = devm_regmap_init_i2c(client, &max_tcpci_regmap_config);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  385  	if (IS_ERR(chip->data.regmap)) {
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  386  		dev_err(&client->dev, "Regmap init failed\n");
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  387  		return PTR_ERR(chip->data.regmap);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  388  	}
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  389  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  390  	chip->dev = &client->dev;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  391  	i2c_set_clientdata(client, chip);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  392  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  393  	ret = max_tcpci_read8(chip, TCPC_POWER_STATUS, &power_status);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  394  	if (ret < 0)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  395  		return ret;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  396  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  397  	/* Chip level tcpci callbacks */
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  398  	chip->data.set_vbus = max_tcpci_set_vbus;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  399  	chip->data.start_drp_toggling = max_tcpci_start_toggling;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  400  	chip->data.TX_BUF_BYTE_x_hidden = true;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  401  	chip->data.init = tcpci_init;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  402  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  403  	max_tcpci_init_regs(chip);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  404  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  405  	if (IS_ERR_OR_NULL(chip->tcpci)) {

When a function returns both NULL and error pointers that means that
it is an optional feature and it has been deliberately disabled.  In
that case we cannot return a pointer to the feature (it is turned off)
but it's also not an error so we don't want to return an error pointer
so we return NULL.

So probe should handle the NULL return and continue.

But actually in this case tcpci_register_port() is not optional and
never returns NULL.  Just replace IS_ERR_OR_NULL() with IS_ERR().

6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  406  		dev_err(&client->dev, "TCPCI port registration failed");
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07 @407  		ret = PTR_ERR(chip->tcpci);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  408  		return PTR_ERR(chip->tcpci);

returning NULL would mean returning success here.

6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  409  	}
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  410  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  411  	ret = max_tcpci_init_alert(chip, client);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  412  	if (ret < 0)
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  413  		goto unreg_port;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  414  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  415  	device_init_wakeup(chip->dev, true);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  416  	return 0;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  417  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  418  unreg_port:
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  419  	tcpci_unregister_port(chip->tcpci);
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  420  
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  421  	return ret;
6f413b559f86a28 Badhri Jagan Sridharan 2020-10-07  422  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--E5RiUMWuxyMNPNnv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--E5RiUMWuxyMNPNnv--
